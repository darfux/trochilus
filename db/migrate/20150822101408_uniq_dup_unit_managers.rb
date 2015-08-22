class UniqDupUnitManagers < ActiveRecord::Migration
  def up
    bucket = {}

    ActiveRecord::Base.transaction do
      UnivUnitManager.all.each do |m|
        if bucket[m.name].nil?
          bucket[m.name] = m
          next
        end      

        uniq_m = bucket[m.name]
        puts "Checked duplicate manager #{m.name} uniq:#{uniq_m.id} dup:#{m.id}"

        puts "Handle projects"
        m.projects.each do |p|
          puts "\tMove project #{p.name} #{p.id}"
          p.create_manager = uniq_m
          p.save!
        end

        puts "Handle execute record"
        m.executed_usage_records.each do |r|
          puts "\tMove execute record #{r.id}"
          r.exec_manager = uniq_m
          r.save!
        end

        puts "Handle benefit record"
        m.benefitted_usage_records.each do |r|
          puts "\tMove benefit record #{r.id}"
          r.benefit_manager = uniq_m
          r.save!
        end

        puts "Deleting duplicate mamanger..."
        m.delete
        puts "===Over==="
        puts
      end
    end
  end
end
