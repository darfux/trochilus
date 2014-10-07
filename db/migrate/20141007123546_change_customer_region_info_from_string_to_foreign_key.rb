class ChangeCustomerRegionInfoFromStringToForeignKey < ActiveRecord::Migration
  def up
    Rake.application["db:import_data"].invoke('loc_info')
    change_table :customers do |t|
      t.references :region_country
      t.references :region_state
      t.references :region_city
    end
    Customer.reset_column_information
    puts "===Converting region info==="
    Customer.all.each do |c|
      ids = {}
      flag = false
      scopes = [:country, :state, :city]
      scopes.each do |s|
        if ( name=c.send(s==:state ? :province : s) ) && !name.empty?
          region = "Region::#{s.to_s.classify}".constantize.where(name: name).first
          if region.nil?
            flag = true
          else
            ids["region_#{s}_id"] = region.id
          end
        end
      end
      if flag
        loop do
          ar =(
            case c.id
            when 5,83,85,106,107,264 then ['中国', '香港']
            when 34 then ['中国', '澳门']
            when 6 then ['中国', '天津', '滨海新区']
            when 7,10,20,26,28,29,31,32,65,67,68,74,103,105,119,123,189,212,213,231,233,235,243,252,258 then ['中国', '天津']
            when 66 then ['中国', '天津', '北辰']
            when 11 then ['中国', '广东', '深圳']
            when 21,78,95,113,139,161,227,251 then ['中国', '北京']
            when 33,38,61,69,181,239,240,241 then ['中国', '上海']
            when 101 then ['中国', '江苏', '苏州']
            when 184 then ['中国', '四川', '成都']
            when 218,219,221 then ['中国', '福建', '福州']
            else 
              puts "Manually input region for \n#{c.inspect}\n[country,state,city]:\n"
              STDIN.gets.chomp.chomp.split(',')
            end
          )
          next unless scopes.each_with_index do |s, i|
            region = ar[i].nil?||ar[i].empty? ? false : "Region::#{s.to_s.classify}".constantize.where(name: ar[i]).first
            if region.nil?
              puts "=>Wrong input, repeat"
              break false
            end
            ids["region_#{s}_id"] = region ? region.id : nil
            true
          end
          break
        end
      end
      c.update(ids)
    end
    puts "===Convert complete"
    change_table :customers do |t|
      t.remove :country
      t.remove :province
      t.remove :city
    end
  end
end
