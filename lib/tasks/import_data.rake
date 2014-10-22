desc "Static data import"


namespace :db do
task :import_data, [:args] => :environment do |t, args|
  datas = [ 
            :project_types,   :project_levels,  :project_states, 
            :fund_types,       :currencies,
            :usage_types,     :donation_types,
            :univ_units,      :univ_unit_managers, :majors, :degrees,
            :teacher_titles,
            :corporate_customer_link_man_link_types,
            :loc_infos
          ]
  if args[:args]
    subjects = datas & args[:args].split('+').collect{ |e| e.pluralize.to_sym }
  end
  Rails.root.join
  if RUBY_VERSION < '2.1.0'
    require './lib/patches/array#to_h.rb'
  end
  subjects.each do |name|
    if name != :loc_infos
      klass = nil
      Rails.application.eager_load!
      ActiveRecord::Base.descendants.each do |k|
        if k.table_name == name.to_s
          klass = k
          break
        end
      end
      raise "No class match table #{name}" unless klass
      if klass.all.count != 0
        puts "===#{klass.to_s}\talready has data, skipped==="
        next
      end
      DatabaseCleaner.clean_with(:truncation, :only => [name])#reset the id
      import_plain_data(name, klass)
      puts "===#{klass.to_s} import complete==="
    else
      klass = "Region"
      import_loc_info
    end
  end
  if subjects.empty?
    puts "Nothing to do.Wrong arguments? #{args[:args]}"
  else
    puts "====All data import complete[#{Rails.env}]===="
  end
end
def import_plain_data(name, klass)
  File.open("./lib/tasks/data/#{name}", 'r') do |f|
    e = f.each_line
    attr_names = e.next.chomp.split
    klass.transaction do
      loop do
        attrs = (
          tmp = []
          [attr_names, e.next.chomp.split].transpose.each do |pair|
            tmp<<(
              if pair[0].include? '@'
                id_name, id = nil
                pair[0].split('@').tap do |ar|
                  id_name = (ar[0].singularize+'_id').to_sym
                  f_klass = ar[0].classify.constantize
                  id = f_klass.find_by(ar[1].to_sym => pair[1]).id
                end
                [id_name, id]
              else
                [pair[0].to_sym, pair[1]]
              end)
          end
          tmp
        ).to_h
        klass.find_or_create_by(attrs)
      end
    end
  end
end

def import_loc_info
  require 'nokogiri'
  if Region::Country.all.count != 0
    puts "===Region\talready has data, skipped==="
    return
  end
  get_info = proc { |obj| 
    {name: obj.attr('Name')||'默认', code: obj.attr('Code')} 
  }
  doc = Nokogiri::XML(File.open("./lib/tasks/data/LocList.xml", 'r'))
  DatabaseCleaner.clean_with(:truncation, :only => [:region_countries, :region_states, :region_cities])
  begin
    puts "<==Start importing region info==>"
    country = state = city = nil
    ActiveRecord::Base.transaction do # without this the importing action will be very very slow.
      (doc/'CountryRegion').each do |country|
        info = get_info.call(country)
        co = Region::Country.create!(info)
        # puts "\timporting country #{info[:name]}"
        (country/'State').each do |state|
          info = get_info.call(state)
          st = Region::State.create! info.merge(region_country_id: co.id)
          # puts "\t\timporting state #{info[:name]}"
          (state/'City').each do |city|
            info = get_info.call(city)
            Region::City.create! info.merge(region_state_id: st.id)
            # puts "\t\t\timporting city #{info[:name]}"
          end
        end
      end
    end
  rescue Exception => e
    puts e
    puts get_info.call(country), get_info.call(state), get_info.call(city)
  end
  puts "===Region\timport complete==="
end
end