desc "ProjectState data import"  
task :import_project_state => :environment do
  Rails.root.join
  DATA = File.open('./lib/tasks/data/project_state', 'r')

  e = DATA.each_line
  ProjectState.transaction do
    loop do
      attrs = {name: e.next.chomp}
      # puts "handling #{attrs}"
      ProjectState.find_or_create_by(attrs)
    end
  end
  puts "===ProjectState import complete==="
end