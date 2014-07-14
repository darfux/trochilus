desc "ProjectLevel data import"  
task :import_project_level => :environment do
  Rails.root.join
  DATA = File.open('./lib/tasks/data/project_level.data', 'r')

  e = DATA.each_line
  ProjectLevel.transaction do
    loop do
      attrs = {name: e.next.chomp}
      # puts "handling #{attrs}"
      ProjectLevel.find_or_create_by(attrs)
    end
  end
  puts "===ProjectLevel import complete==="
end