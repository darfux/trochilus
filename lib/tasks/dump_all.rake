namespace :db do
  namespace :seed  do
    desc "Dump records with all from the database into db/seeds.rb"
    task :dump_all => :environment do
      ENV['EXCLUDE'] = ''
      SeedDump.dump_using_environment(ENV)
    end
  end
end