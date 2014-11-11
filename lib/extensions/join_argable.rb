module JoinArgable
  PackageManager.use('SimpleReflector')
  extend ActiveSupport::Concern
  module ClassMethods
    def join_arg(name, selfas, conditions = {}, type=:inner)
      klass, target_alias = (
        case name
        when Symbol
          reflections[name].klass
        when String
          reflections[name.to_sym].klass
        when Hash
          k = name.first[0]
          [reflections[k].klass, name[k][:as]]
        end
      )
      target_reflector, self_alias = (
        case selfas
        when Symbol, String
          klass.simple_reflect(selfas)
        when Hash
          k = selfas.first[0]
          [klass.simple_reflect(k), selfas[k][:as]]
        end
      )
      target_table_name = klass.table_name
      tf = target_reflector
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
        target_name = target_alias||target_table_name
        self_name = self_alias||self.table_name
        tmp = %Q{ #{join} JOIN "#{target_table_name}" #{"as "+target_alias.to_s if target_alias} } +
          %Q{ ON "#{target_name}"."#{fk}" = "#{self_name}"."#{pk}" }
        if target_reflector.polymorphic
          ft = target_reflector.foreign_type
          tmp << %Q{ AND "#{target_name}"."#{ft}" = "#{self}" }
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