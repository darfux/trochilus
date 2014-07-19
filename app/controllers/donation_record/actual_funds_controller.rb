class DonationRecord::ActualFundsController < ApplicationController
  before_action :set_donation_record_actual_fund, only: [:show, :edit, :update, :destroy]
  before_action :set_donation_record, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :edit, :update]
  # GET /donation_record/actual_funds
  # GET /donation_record/actual_funds.json
  def index
    @donation_record_actual_funds = DonationRecord::ActualFund.all
  end

  # GET /donation_record/actual_funds/1
  # GET /donation_record/actual_funds/1.json
  def show
  end

  # GET /donation_record/actual_funds/new
  def new
    @donation_record_actual_fund = DonationRecord::ActualFund.new
    unless @donation_record.project.endowment
      @donation_record_actual_fund.fund_type = FundType.where(name: '本金').first
    end
    # raise params.inspect
  end

  # GET /donation_record/actual_funds/1/edit
  def edit
    # raise @donation_record_actual_fund.inspect
  end

  # POST /donation_record/actual_funds
  # POST /donation_record/actual_funds.json
  def create
    # raise donation_record_actual_fund_params.inspect
    @donation_record_actual_fund = DonationRecord::ActualFund.new(donation_record_actual_fund_params)
    @donation_record_actual_fund.donation_record = @donation_record

    respond_to do |format|
      if @donation_record_actual_fund.save
        format.html { redirect_to @donation_record, notice: 'Actual fund was successfully created.' }
        format.json { render :show, status: :created, location: @donation_record_actual_fund }
      else
        format.html { render :new }
        format.json { render json: @donation_record_actual_fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donation_record/actual_funds/1
  # PATCH/PUT /donation_record/actual_funds/1.json
  def update
    respond_to do |format|
      if @donation_record_actual_fund.update(donation_record_actual_fund_params)
        format.html { redirect_to @donation_record, notice: 'Actual fund was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation_record_actual_fund }
      else
        format.html { render :edit }
        format.json { render json: @donation_record_actual_fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donation_record/actual_funds/1
  # DELETE /donation_record/actual_funds/1.json
  def destroy
    @donation_record_actual_fund.destroy
    respond_to do |format|
      format.html { redirect_to @donation_record, notice: 'Actual fund was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_record_actual_fund
      @donation_record_actual_fund = DonationRecord::ActualFund.find(params[:id])
    end

    def set_donation_record
      @donation_record =  (
        if @donation_record_actual_fund && @donation_record_actual_fund.donation_record
          @donation_record_actual_fund.donation_record
        else
          DonationRecord.find(params[:donation_record_id])
        end
      )
    end

    def set_project
      @project = @donation_record.project
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_record_actual_fund_params
      params.require(:donation_record_actual_fund)
        .permit( :fund_type_id, fund_attributes: [:amount, :time, :comment] )
    end
end
