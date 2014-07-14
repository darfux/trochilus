desc "ProjectType data import"  
task :import_project_type => :environment do
  Rails.root.join
  DATA = File.open('./lib/tasks/data/project_type', 'r')

  e = DATA.each_line
  ProjectType.transaction do
    loop do
      attrs = {name: e.next.chomp}
      # puts "handling #{attrs}"
      ProjectType.find_or_create_by(attrs)
    end
  end
  puts "===ProjectType import complete==="
end