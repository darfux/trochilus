module Employee::ManageHelper
  def judge_sf(c)
    return false unless c.customer.class == IndividualCustomer
    c.customer.schoolfellow ? true : false
  end
  def decorate_amount(amount)
    html = (
      if amount>=0
        content_tag(:td, amount, :class => 'fund-amount-show positive')
      else
        content_tag(:td, amount, :class => 'fund-amount-show negative')
      end
    )
  end
  def gen_sort(text, col)
    if params[:col] == col.to_s
      opt = (
        case tmp=params[:sort]
        when '1'
          -1
        when '-1'
          col = nil
          nil
        end
      )
      decor = (
        case tmp.to_i
        when 1
          ' ↓'
        when -1
          ' ↑'
        end
      )
    else
      opt = 1
      decor = ''
    end
    sort_params = {col: col, sort: opt}
    link_to text+decor, current_path(sort_params)
  end
  def select_existed(host_klass, dest)
    host_table = host_klass.table_name
    dest_klass = 
      (klass = host_klass.reflect_on_association(dest).options[:class_name]).nil? ? dest.to_s.classify.constantize : klass.to_s.constantize
    dest_table = dest_klass.table_name
    options_from_collection_for_select(
      host_klass.group("#{dest}_id")
      .joins(dest)
      .select("'#{dest_table}'.'name', '#{dest_table}'.'id'"), :id, :name, default_filter_val(dest)
    )
  end
  def default_filter_val(filter)
    (f = params[:filters]).nil? ? nil : f[filter]
  end
end
