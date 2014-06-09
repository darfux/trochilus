class UnivUnitManagersController < ApplicationController
  # GET /univ_unit_managers
  # GET /univ_unit_managers.json
  def index
    @univ_unit_managers = UnivUnitManager.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @univ_unit_managers }
    end
  end

  # GET /univ_unit_managers/1
  # GET /univ_unit_managers/1.json
  def show
    @univ_unit_manager = UnivUnitManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @univ_unit_manager }
    end
  end

  # GET /univ_unit_managers/new
  # GET /univ_unit_managers/new.json
  def new
    @univ_unit_manager = UnivUnitManager.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @univ_unit_manager }
    end
  end

  # GET /univ_unit_managers/1/edit
  def edit
    @univ_unit_manager = UnivUnitManager.find(params[:id])
  end

  # POST /univ_unit_managers
  # POST /univ_unit_managers.json
  def create
    @univ_unit_manager = UnivUnitManager.new(univ_unit_manager_params)

    respond_to do |format|
      if @univ_unit_manager.save
        format.html { redirect_to @univ_unit_manager, notice: 'Univ unit manager was successfully created.' }
        format.json { render json: @univ_unit_manager, status: :created, location: @univ_unit_manager }
      else
        format.html { render action: "new" }
        format.json { render json: @univ_unit_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /univ_unit_managers/1
  # PATCH/PUT /univ_unit_managers/1.json
  def update
    @univ_unit_manager = UnivUnitManager.find(params[:id])

    respond_to do |format|
      if @univ_unit_manager.update_attributes(univ_unit_manager_params)
        format.html { redirect_to @univ_unit_manager, notice: 'Univ unit manager was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @univ_unit_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /univ_unit_managers/1
  # DELETE /univ_unit_managers/1.json
  def destroy
    @univ_unit_manager = UnivUnitManager.find(params[:id])
    @univ_unit_manager.destroy

    respond_to do |format|
      format.html { redirect_to univ_unit_managers_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def univ_unit_manager_params
      params.require(:univ_unit_manager).permit(:name, :univ_unit_id)
    end
end
