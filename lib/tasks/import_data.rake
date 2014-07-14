desc "Static data import"

DATAS = [:project_types, :project_levels, :project_states, :donation_types, :currencies]

task :import_data => :environment do
  Rails.root.join
  DATAS.each do |name|
    DatabaseCleaner.clean_with(:truncation, :only => [name])
    File.open("./lib/tasks/data/#{name}", 'r') do |f|
      klass = name.to_s.classify.constantize
      e = f.each_line
      attr_names = e.next.chomp.split.collect{ |e| e.to_sym}
      klass.transaction do
        loop do
          attrs = [attr_names, e.next.chomp.split].transpose.to_h

          klass.find_or_create_by(attrs)
        end
      end
      puts "===#{klass.to_s} import complete==="
    end
  end
  puts "====All data import complete===="
end