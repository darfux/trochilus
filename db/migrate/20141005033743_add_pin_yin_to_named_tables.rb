class AddPinYinToNamedTables < ActiveRecord::Migration
  def up
    migrate_id = File.basename(__FILE__).split('_')[0]
    db_path = "#{Rails.root}/db/#{Rails.env}.sqlite3"
    db_bak_path = db_path+".bak_#{migrate_id}"
    FileUtils.cp(db_path, db_bak_path)
    begin
      klasses = [
        "Employee", "Project", "FundType", "Customer", "Currency", 
        "Degree", "DonationType", "Major", "ProjectLevel", "ProjectState", 
        "ProjectType", "TeacherTitle", "UnivUnit", "UnivUnitManager", "UsageType"
      ].map{ |name| name.constantize}
      nc = :name_abbrpy
      klasses.each do |klass|
        t = klass.table_name.to_sym
        add_column t, nc, :text
        add_index t, nc
      end
      klasses.each do |klass|
        klass.reset_column_information # http://guides.rubyonrails.org/migrations.html#using-models-in-your-migrations
        puts "==Coverting name to pinyin for #{klass}"
        klass.transaction do
          klass.all.each do |r|
            r.send("#{nc}=", PinYin.abbr(r.name))
            r.save!
          end
        end
      end
    rescue Exception => e  
      FileUtils.mv(db_bak_path, db_path)
      puts e.message
      puts e.backtrace
      raise "Migration failed"
    end
    bak_directory = "#{Rails.root}/db/migrate_db_bak/"
    Dir.mkdir bak_directory unless Dir.exists? bak_directory
    FileUtils.mv(db_bak_path, "#{bak_directory}#{File.basename(db_bak_path)}")
  end
end