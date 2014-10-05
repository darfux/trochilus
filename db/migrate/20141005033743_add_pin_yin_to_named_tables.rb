class AddPinYinToNamedTables < ActiveRecord::Migration
  def up
    migrate_id = File.basename(__FILE__).split('_')[0]
    db_path = "#{Rails.root}/db/#{Rails.env}.sqlite3"
    db_bak_path = db_path+".bak_#{migrate_id}"
    FileUtils.cp(db_path, db_bak_path)
    begin
      Rails.application.eager_load!
      ActiveRecord::Base.descendants.each do |klass|  
        klass.columns.each do |c| 
          if c.name=="name"
            t = klass.table_name.to_sym
            nc = :name_abbrpy
            add_column t, nc, :text
            add_index t, nc
            klass.reset_column_information # http://guides.rubyonrails.org/migrations.html#using-models-in-your-migrations
            klass.all.each do |r|
              r.send("#{nc}=", PinYin.abbr(r.name))
              r.save!
            end
            break
          end
        end
      end
    rescue Exception => e  
      FileUtils.mv(db_bak_path, db_path)
      puts e.message  
      raise "Migration failed"
    end
    bak_directory = "#{Rails.root}/db/migrate_db_bak/"
    Dir.mkdir bak_directory unless Dir.exists? bak_directory
    FileUtils.mv(db_bak_path, "#{bak_directory}#{File.basename(db_bak_path)}")
  end
end
