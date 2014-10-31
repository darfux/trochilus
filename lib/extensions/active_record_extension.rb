module ActiveRecordExtension
  PackageManager.use('ModelFilter')
  module Inner
    extend ActiveSupport::Concern
    # add your instance methods here
    
    # add your static(class) methods here
    include HasPinYinName, JoinArgable
    module ClassMethods
      def validates_presence_of_all(*args, except: [])
        all = (
          a = column_names.collect do |e|
                if e[-3..-1]=='_id' && self.method_defined?(e[0..-4])
                  e[0..-4]
                else
                  e
                end
              end
          a - (['id', 'created_at', 'updated_at'] + Array(except)).collect{|e| e.to_s}
        )
        validates_presence_of all
        all
      end
      def search_type(attribute)
        "#{self.to_s.underscore}##{attribute}"
      end
      def foreign_keys
        return @__foreign_keys if @__foreign_keys
        fks = {}
        (
          proc do
            reflect_on_all_associations(:belongs_to).each do |a| 
              name = a.name
              fk = ( 
                tmpfk = ((tmp=a.options[:foreign_key]) ? tmp : ("#{name}_id")).to_sym
                if options[:polymorphic]==true
                  tmpft = a.options[:foreign_type] || "#{name}_type".to_sym
                  tmp = [tmpfk, tmp]
                end
                #@options={:polymorphic=>true, :foreign_key=>:fund_instance_id, :foreign_type=>:fund_instance_type}
              )
              fks[] = name
            end
          end
        ).call()
        @__foreign_keys = fks
      end
    end
  end
  include InnerForAllSubclass
end