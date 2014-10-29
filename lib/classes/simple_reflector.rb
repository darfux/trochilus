class SimpleReflector
  attr_reader :name, :klass, :macro, :polymorphic, :foreign_key, :primary_key, :table_name, :foreign_type
  def initialize(reflection)
    r = reflection
    ar = r.active_record
    @name = r.name
    @macro = r.macro
    @polymorphic  = r.options[:polymorphic]==true
    @klass = r.klass unless @polymorphic
    @foreign_key  = (
      case @macro
      when :belongs_to
        (r.options[:foreign_key]   || r.class_name.foreign_key).to_sym
      else
        (r.options[:foreign_key]   || ar.to_s.foreign_key).to_sym
      end
    )
    @primary_key  = r.options[:primary_key]   || :id
    @table_name   = @klass.table_name.to_sym if @klass
    if @polymorphic
      @foreign_type = (r.options[:foreign_type]  || @foreign_key[0..-4]+"_type").to_sym
    end
  end
end
