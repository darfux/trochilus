module JoinArgable
  PackageManager.use('SimpleReflector')
  extend ActiveSupport::Concern
  module ClassMethods
    def join_arg(name, selfas, conditions = {}, type=:inner)
      klass = reflections[name.to_sym].klass
      target_reflector = tf = klass.simple_reflect(selfas)
      target_table_name = klass.table_name
      fk = tf.foreign_key
      pk = tf.primary_key
      join = (
        case type
        when :inner
          'INNER'
        when :outer
          'LEFT OUTER'
        else
          raise 'wrong join type'
        end
      )
      sql = (
        tmp = %Q{ #{join} JOIN "#{target_table_name}" ON "#{target_table_name}"."#{fk}" = "#{self.table_name}"."#{pk}" }
        if target_reflector.polymorphic
          ft = target_reflector.foreign_type
          tmp << %Q{ AND "#{target_table_name}"."#{ft}" = "#{self}" }
        end
        if conditions
          conditions.each_pair do |table, values|
            values.each_pair do |col, v|
              tmp << %Q{ AND ("#{table}"."#{col}" } + (
                case v
                when Range
                  " BETWEEN '#{v.begin}' AND '#{v.end}'"
                else
                  " == '#{v}'"
                end
              ) + ')'
            end
          end
        end
        tmp
      )
    end

    def outerjoin_arg(name, selfas, conditions = {})
      join_arg(name, selfas, conditions, :outer)
    end
  end
end