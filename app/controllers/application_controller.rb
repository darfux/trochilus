class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :set_layout
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:account, :email, :password, :password_confirmation) }
    end

    def current_people
      @current_people ||= current_user ? current_user.user : nil
    end
    
    def set_layout
      return current_people.user_type!.downcase.to_s if current_people
      "application"
    end

    def handle_sort(relation)
      unless col = params[:col]
        relation
      else
        desc = params[:sort]=='1' ? true : false
        # binding.pry
        tmp = relation.sort_by{|p| p.send(col)}
        tmp = tmp.reverse if desc
        tmp
      end
    end
    def handle_filter(relation, filters=nil)
      filters ||= params[:filters]
      return relation unless f = filters
      f && f.each_pair do |k,v| 
        f[k] = true   if v=='true'
        f[k] = false  if v=='false'
        if v.is_a?(Hash) && (v['from'] || v['to'])
          from = ((from=v['from']) ? from : Time.new(0))
          to = ((to=v['to']) ? to : Time.new(9999))
          f[k] = from..to
        end
      end
      relation.where(f)
    end
end
