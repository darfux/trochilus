class FundTypesController < ApplicationController
  before_action :set_fund_type, only: [:show, :edit, :update, :destroy]

  # GET /fund_types
  # GET /fund_types.json
  def index
    @fund_types = FundType.all
  end

  # GET /fund_types/1
  # GET /fund_types/1.json
  def show
  end

  # GET /fund_types/new
  def new
    @fund_type = FundType.new
  end

  # GET /fund_types/1/edit
  def edit
  end

  # POST /fund_types
  # POST /fund_types.json
  def create
    @fund_type = FundType.new(fund_type_params)

    respond_to do |format|
      if @fund_type.save
        format.html { redirect_to @fund_type, notice: 'Fund type was successfully created.' }
        format.json { render :show, status: :created, location: @fund_type }
      else
        format.html { render :new }
        format.json { render json: @fund_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fund_types/1
  # PATCH/PUT /fund_types/1.json
  def update
    respond_to do |format|
      if @fund_type.update(fund_type_params)
        format.html { redirect_to @fund_type, notice: 'Fund type was successfully updated.' }
        format.json { render :show, status: :ok, location: @fund_type }
      else
        format.html { render :edit }
        format.json { render json: @fund_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fund_types/1
  # DELETE /fund_types/1.json
  def destroy
    @fund_type.destroy
    respond_to do |format|
      format.html { redirect_to fund_types_url, notice: 'Fund type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fund_type
      @fund_type = FundType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fund_type_params
      params.require(:fund_type).permit(:name)
    end
end
