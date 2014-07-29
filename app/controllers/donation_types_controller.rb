class DonationTypesController < ApplicationController
  before_action :set_donation_type, only: [:show, :edit, :update, :destroy]

  # GET /donation_types
  # GET /donation_types.json
  def index
    @donation_types = DonationType.all
  end

  # GET /donation_types/1
  # GET /donation_types/1.json
  def show
  end

  # GET /donation_types/new
  def new
    @donation_type = DonationType.new
  end

  # GET /donation_types/1/edit
  def edit
  end

  # POST /donation_types
  # POST /donation_types.json
  def create
    @donation_type = DonationType.new(donation_type_params)

    respond_to do |format|
      if @donation_type.save
        format.html { redirect_to @donation_type }
        format.json { render :show, status: :created, location: @donation_type }
      else
        format.html { render :new }
        format.json { render json: @donation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donation_types/1
  # PATCH/PUT /donation_types/1.json
  def update
    respond_to do |format|
      if @donation_type.update(donation_type_params)
        format.html { redirect_to @donation_type }
        format.json { render :show, status: :ok, location: @donation_type }
      else
        format.html { render :edit }
        format.json { render json: @donation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donation_types/1
  # DELETE /donation_types/1.json
  def destroy
    @donation_type.destroy
    respond_to do |format|
      format.html { redirect_to donation_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_type
      @donation_type = DonationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_type_params
      params.require(:donation_type).permit(:name)
    end
end
