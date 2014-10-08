class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, 
    :new_attachment, :create_attachment, :destroy_attachment]
  before_action :set_attachments, only: [:show]
  before_action :set_statistics_info, only: [:show]
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    if !user_can
      render 'cant_edit'
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.creator = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    respond_to do |format|
      if user_can
        @project.destroy
        format.html { redirect_to employee_manage_projects_path }
        format.json { head :no_content }
      else
        format.html { render 'cant_edit' }
      end
    end
  end

  def new_attachment
    @attachment = Attachment.new
  end

  def create_attachment
    @attachment = Attachment.create(attachment_params)
    redirect_to @project
  end

  def destroy_attachment
    @attachment = Attachment.find(params[:attachment_id])
    raise 'unmatched project' if @project != @attachment.owner
    @attachment.destroy
    redirect_to @project
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def user_can
      #@project.creator == current_user
      true
    end

    def set_attachments
      @attachments = @project.attachments
    end

    def set_statistics_info
      @all_plan_amount = @project.total_amount
      @all_actual_amount = @project.actual_amount
      @all_interest_amount = @project.interest_amount

      @principle_used_amount = @project.principle_used
      @interest_used_amount = @project.interest_used

      @all_principle_rest = @all_plan_amount - @principle_used_amount
      @actual_principle_rest = @all_actual_amount - @principle_used_amount
      @intereset_rest = @all_interest_amount - @interest_used_amount
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :serialnum, :create_date, :funder, :brief, :interest_rate,
        :gross, :balance, :endowment, :project_level_id, :project_state_id, :project_type_id, :comment,
        :create_unit_id, :create_manager_id)
    end
    def attachment_params
      params.require(:attachment).permit(:file).tap{ |p| p[:attachment_owner]=@project }
    end
end
