module Fux
  class SimpleReflector
    @@reflect_class_table = {}
    @@refect_column_table = {}
    def initialize(ar, reflection)
      r = reflection
      @klass = r.klass
      @polymorphic  = r.options[:polymorphic]==true
      @foreign_key  = r.options[:foreign_key]   || ar.to_s.foreign_key
      @primary_key  = r.options[:primary_key]   || :id
      @table_name   = klass.table_name
      if @polymorphic
        @foreign_type = r.options[:foreign_type]  || @foreign_key[0..-4]+"_type"
      end
    end
  end

  def initilize_reflect_table
    self.reflect_on_all_associations.each do |r|
      reflector = SimpleReflector.new(self,r)
      reflect_class_table[reflector.klass] = refect_column_table[reflector.name] = reflector
    end
  end


  def reflect_class(klass)
    table.get_by_class(klass)
  end

  class Table
    def get_by_class(klass)
      self.class_table[klass]
    end 
  end
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