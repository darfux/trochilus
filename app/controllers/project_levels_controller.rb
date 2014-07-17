class ProjectLevelsController < ApplicationController
  before_action :set_project_level, only: [:show, :edit, :update, :destroy]

  # GET /project_levels
  # GET /project_levels.json
  def index
    @project_levels = ProjectLevel.all
  end

  # GET /project_levels/1
  # GET /project_levels/1.json
  def show
  end

  # GET /project_levels/new
  def new
    @project_level = ProjectLevel.new
  end

  # GET /project_levels/1/edit
  def edit
  end

  # POST /project_levels
  # POST /project_levels.json
  def create
    @project_level = ProjectLevel.new(project_level_params)

    respond_to do |format|
      if @project_level.save
        format.html { redirect_to @project_level, notice: 'Project level was successfully created.' }
        format.json { render :show, status: :created, location: @project_level }
      else
        format.html { render :new }
        format.json { render json: @project_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_levels/1
  # PATCH/PUT /project_levels/1.json
  def update
    respond_to do |format|
      if @project_level.update(project_level_params)
        format.html { redirect_to @project_level, notice: 'Project level was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_level }
      else
        format.html { render :edit }
        format.json { render json: @project_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_levels/1
  # DELETE /project_levels/1.json
  def destroy
    @project_level.destroy
    respond_to do |format|
      format.html { redirect_to project_levels_url, notice: 'Project level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_level
      @project_level = ProjectLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_level_params
      params.require(:project_level).permit(:name)
    end
end
