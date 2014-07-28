desc "Static data import"

datas = [ 
          :project_types,   :project_levels,  :project_states, 
          :fund_types,       :currencies,
          :usage_types,     :donation_types,
          :univ_units,      :univ_unit_managers, :majors, :degrees,
          :teacher_titles
        ]

namespace :db do
task :import_data, [:args] => :environment do |t, args|
  if args[:args]
    datas &= args[:args].split('+').collect{ |e| e.to_sym }
  end
  Rails.root.join
  if RUBY_VERSION < '2.1.0'
    require './lib/patches/array#to_h.rb'
  end
  datas.each do |name|
    DatabaseCleaner.clean_with(:truncation, :only => [name])
    File.open("./lib/tasks/data/#{name}", 'r') do |f|
      klass = name.to_s.classify.constantize
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
      puts "===#{klass.to_s} import complete==="
    end
  end
  puts "====All data import complete===="
end
end