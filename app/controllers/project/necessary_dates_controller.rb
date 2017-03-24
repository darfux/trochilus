class Project::NecessaryDatesController < ApplicationController
  before_action :set_project_necessary_date, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create, :new, :edit, :destroy]

  # GET /project/necessary_dates
  # GET /project/necessary_dates.json
  def index
    @project_necessary_dates = Project::NecessaryDate.all
  end

  # GET /project/necessary_dates/1
  # GET /project/necessary_dates/1.json
  def show
  end

  # GET /project/necessary_dates/new
  def new
    @project_necessary_date = Project::NecessaryDate.new
    @project_necessary_date.project = @project
  end

  # GET /project/necessary_dates/1/edit
  def edit
  end

  # POST /project/necessary_dates
  # POST /project/necessary_dates.json
  def create
    @project_necessary_date = Project::NecessaryDate.new(project_necessary_date_params)
    @project_necessary_date.date = @project_necessary_date.date.change(year: 1900)

    respond_to do |format|
      if @project_necessary_date.save
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @project_necessary_date }
      else
        format.html { render :new }
        format.json { render json: @project_necessary_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project/necessary_dates/1
  # PATCH/PUT /project/necessary_dates/1.json
  def update
    respond_to do |format|
      if @project_necessary_date.update(project_necessary_date_params)
        format.html { redirect_to @project_necessary_date }
        format.json { render :show, status: :ok, location: @project_necessary_date }
      else
        format.html { render :edit }
        format.json { render json: @project_necessary_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project/necessary_dates/1
  # DELETE /project/necessary_dates/1.json
  def destroy
    @project_necessary_date.destroy
    respond_to do |format|
      format.html { redirect_to @project }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_necessary_date
      @project_necessary_date = Project::NecessaryDate.find(params[:id])
    end

    def set_project
      @project = (@project_necessary_date && @project_necessary_date.project) || Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_necessary_date_params
      params.require(:project_necessary_date).permit(:date, :comment, :project_id)
    end
end
