class UndeterminedFundsController < ApplicationController
  before_action :set_undetermined_fund, only: [:show, :edit, :update, :destroy]

  # GET /undetermined_funds
  # GET /undetermined_funds.json
  def index
    @undetermined_funds = UndeterminedFund.all
  end

  # GET /undetermined_funds/1
  # GET /undetermined_funds/1.json
  def show
  end

  # GET /undetermined_funds/new
  def new
    @undetermined_fund = UndeterminedFund.new
  end

  # GET /undetermined_funds/1/edit
  def edit
  end

  # POST /undetermined_funds
  # POST /undetermined_funds.json
  def create
    @undetermined_fund = UndeterminedFund.new(undetermined_fund_params)

    respond_to do |format|
      if @undetermined_fund.save
        format.html { redirect_to employee_manage_funds_path }
        format.json { render :show, status: :created, location: @undetermined_fund }
      else
        format.html { render :new }
        format.json { render json: @undetermined_fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /undetermined_funds/1
  # PATCH/PUT /undetermined_funds/1.json
  def update
    respond_to do |format|
      if @undetermined_fund.update(undetermined_fund_params)
        format.html { redirect_to @undetermined_fund, notice: 'Undetermined fund was successfully updated.' }
        format.json { render :show, status: :ok, location: @undetermined_fund }
      else
        format.html { render :edit }
        format.json { render json: @undetermined_fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /undetermined_funds/1
  # DELETE /undetermined_funds/1.json
  def destroy
    @undetermined_fund.destroy
    respond_to do |format|
      format.html { redirect_to undetermined_funds_url, notice: 'Undetermined fund was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_undetermined_fund
      @undetermined_fund = UndeterminedFund.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def undetermined_fund_params
      params.require(:undetermined_fund).permit( fund_attributes: [:amount, :time, :comment, :currency_id, :origin_amount] )
    end
end
