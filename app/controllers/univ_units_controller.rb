class UnivUnitsController < ApplicationController
  # GET /univ_units
  # GET /univ_units.json
  def index
    @univ_units = UnivUnit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @univ_units }
    end
  end

  # GET /univ_units/1
  # GET /univ_units/1.json
  def show
    @univ_unit = UnivUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @univ_unit }
    end
  end

  # GET /univ_units/new
  # GET /univ_units/new.json
  def new
    @univ_unit = UnivUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @univ_unit }
    end
  end

  # GET /univ_units/1/edit
  def edit
    @univ_unit = UnivUnit.find(params[:id])
  end

  # POST /univ_units
  # POST /univ_units.json
  def create
    @univ_unit = UnivUnit.new(univ_unit_params)

    respond_to do |format|
      if @univ_unit.save
        format.html { redirect_to @univ_unit, notice: 'Univ unit was successfully created.' }
        format.json { render json: @univ_unit, status: :created, location: @univ_unit }
      else
        format.html { render action: "new" }
        format.json { render json: @univ_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /univ_units/1
  # PATCH/PUT /univ_units/1.json
  def update
    @univ_unit = UnivUnit.find(params[:id])

    respond_to do |format|
      if @univ_unit.update_attributes(univ_unit_params)
        format.html { redirect_to @univ_unit, notice: 'Univ unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @univ_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /univ_units/1
  # DELETE /univ_units/1.json
  def destroy
    @univ_unit = UnivUnit.find(params[:id])
    @univ_unit.destroy

    respond_to do |format|
      format.html { redirect_to univ_units_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def univ_unit_params
      params.require(:univ_unit).permit(:name)
    end
end
