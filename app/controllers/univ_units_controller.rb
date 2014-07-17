class UnivUnitsController < ApplicationController
  before_action :set_univ_unit, only: [:show, :edit, :update, :destroy]

  # GET /univ_units
  # GET /univ_units.json
  def index
    @univ_units = UnivUnit.all
  end

  # GET /univ_units/1
  # GET /univ_units/1.json
  def show
  end

  # GET /univ_units/new
  def new
    @univ_unit = UnivUnit.new
  end

  # GET /univ_units/1/edit
  def edit
  end

  # POST /univ_units
  # POST /univ_units.json
  def create
    @univ_unit = UnivUnit.new(univ_unit_params)

    respond_to do |format|
      if @univ_unit.save
        format.html { redirect_to @univ_unit, notice: 'Univ unit was successfully created.' }
        format.json { render :show, status: :created, location: @univ_unit }
      else
        format.html { render :new }
        format.json { render json: @univ_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /univ_units/1
  # PATCH/PUT /univ_units/1.json
  def update
    respond_to do |format|
      if @univ_unit.update(univ_unit_params)
        format.html { redirect_to @univ_unit, notice: 'Univ unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @univ_unit }
      else
        format.html { render :edit }
        format.json { render json: @univ_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /univ_units/1
  # DELETE /univ_units/1.json
  def destroy
    @univ_unit.destroy
    respond_to do |format|
      format.html { redirect_to univ_units_url, notice: 'Univ unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_univ_unit
      @univ_unit = UnivUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def univ_unit_params
      params.require(:univ_unit).permit(:name)
    end
end
