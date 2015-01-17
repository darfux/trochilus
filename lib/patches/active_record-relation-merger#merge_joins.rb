# see https://github.com/rails/rails/issues/15488
if ActiveRecord.version.to_s == "4.1.4"
  module ActiveRecord
    class Relation
      class Merger
        
      private
        def merge_joins
          return if values[:joins].blank?

          if other.klass == relation.klass
            relation.joins!(*values[:joins])
          else
            joins_dependency, rest = values[:joins].partition do |join|
              case join
              when Hash, Symbol, Array
                true
              else
                false
              end
            end

            join_dependency = ActiveRecord::Associations::JoinDependency.new(other.klass,
                                                                             joins_dependency,
                                                                             [])
            relation.joins! *rest

            @relation = relation.joins join_dependency
          end
        end
      
      end
    end
  end
else
  $stderr.puts "ActiveRecord isn't 4.1.4, please check if this patch is nessary."
end