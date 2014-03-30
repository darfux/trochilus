class ProjectStatesController < ApplicationController
  before_action :set_project_state, only: [:show, :edit, :update, :destroy]

  # GET /project_states
  # GET /project_states.json
  def index
    @project_states = ProjectState.all
  end

  # GET /project_states/1
  # GET /project_states/1.json
  def show
  end

  # GET /project_states/new
  def new
    @project_state = ProjectState.new
  end

  # GET /project_states/1/edit
  def edit
  end

  # POST /project_states
  # POST /project_states.json
  def create
    @project_state = ProjectState.new(project_state_params)

    respond_to do |format|
      if @project_state.save
        format.html { redirect_to @project_state, notice: 'Project state was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project_state }
      else
        format.html { render action: 'new' }
        format.json { render json: @project_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_states/1
  # PATCH/PUT /project_states/1.json
  def update
    respond_to do |format|
      if @project_state.update(project_state_params)
        format.html { redirect_to @project_state, notice: 'Project state was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_states/1
  # DELETE /project_states/1.json
  def destroy
    @project_state.destroy
    respond_to do |format|
      format.html { redirect_to project_states_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_state
      @project_state = ProjectState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_state_params
      params.require(:project_state).permit(:name)
    end
end
