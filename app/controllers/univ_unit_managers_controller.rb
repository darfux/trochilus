class UnivUnitManagersController < ApplicationController
  before_action :set_univ_unit_manager, only: [:show, :edit, :update, :destroy]

  # GET /univ_unit_managers
  # GET /univ_unit_managers.json
  def index
    @univ_unit_managers = UnivUnitManager.all
  end

  # GET /univ_unit_managers/1
  # GET /univ_unit_managers/1.json
  def show
  end

  # GET /univ_unit_managers/new
  def new
    @univ_unit_manager = UnivUnitManager.new
  end

  # GET /univ_unit_managers/1/edit
  def edit
  end

  # POST /univ_unit_managers
  # POST /univ_unit_managers.json
  def create
    @univ_unit_manager = UnivUnitManager.new(univ_unit_manager_params)

    respond_to do |format|
      if @univ_unit_manager.save
        format.html { redirect_to @univ_unit_manager }
        format.json { render :show, status: :created, location: @univ_unit_manager }
      else
        format.html { render :new }
        format.json { render json: @univ_unit_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /univ_unit_managers/1
  # PATCH/PUT /univ_unit_managers/1.json
  def update
    respond_to do |format|
      if @univ_unit_manager.update(univ_unit_manager_params)
        format.html { redirect_to @univ_unit_manager }
        format.json { render :show, status: :ok, location: @univ_unit_manager }
      else
        format.html { render :edit }
        format.json { render json: @univ_unit_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /univ_unit_managers/1
  # DELETE /univ_unit_managers/1.json
  def destroy
    @univ_unit_manager.destroy
    respond_to do |format|
      format.html { redirect_to univ_unit_managers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_univ_unit_manager
      @univ_unit_manager = UnivUnitManager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def univ_unit_manager_params
      params.require(:univ_unit_manager).permit(:name, :univ_unit_id, :mobile, :tel, :postcode, :email, :fax)
    end
end
