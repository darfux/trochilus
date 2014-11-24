module Employee::ManageHelper
  def judge_sf(c, with_attr=true)
    return false unless c.customer_type == 'IndividualCustomer'
    c[:schoolfellow] || (!with_attr&&c.customer.schoolfellow) ? true : false
  end

  def decorate_amount(amount)
    html = (
      if amount>=0
        content_tag(:td, money_show(amount), :class => 'fund-amount-show positive')
      else
        content_tag(:td, money_show(amount), :class => 'fund-amount-show negative')
      end
    )
  end

  #NTBI
  def gen_sort(text, attribute)
    if params.direct_fetch([:filters, :st, :attr]) == attribute.to_s
      opt = (
        case tmp=params[:filters][:st][:order]
        when '1'
          -1
        when '-1'
          attribute = nil
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
    sort_params = (
      if opt
        { filters: { st: {attr: attribute, order: opt} } }
      else
        tmp = params[:filters].tap{ |p| p.delete(:st) if p }
        # tmp = params[:filters].dup.tap{ |p| p.delete(:sort) if p }
        tmp.empty? ? params.delete(:filters) : tmp
        {}
      end
    )
    # binding.pry
    link_to text+decor, current_path(sort_params)
  end
end
