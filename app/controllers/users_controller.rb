class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
    redirect_to @user.user
  end
  def search
  end
  def do_search
    search_name = params[:search]
    search_type = params[:type]
    # raise params[:search].inspect
    # project = Project.find(params[:project_id])
    klass = search_type.classify.constantize
    unless search_name
      @users = klass.all
    else
      @users = klass.where(
        "name LIKE ?", "%#{search_name}%")
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end