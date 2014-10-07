class DonationRecord::ActualFundsController < ApplicationController
  before_action :set_donation_record_actual_fund, only: [:new, :show, :edit, :update, :destroy]
  before_action :set_donation_record, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :edit, :update]
  before_action :init_proof, only: [:new, :edit]
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
    @donation_record_actual_fund.fund_type = FundType.where(name: :principle).first #default fund type
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
      @donation_record_actual_fund = (id=params[:id]) ? DonationRecord::ActualFund.find(id) : DonationRecord::ActualFund.new
    end

    def set_donation_record
      @donation_record =  (
        if (f=@donation_record_actual_fund) && f.donation_record
          f.donation_record
        else
          DonationRecord.find(params[:donation_record_id])
        end
      )
    end

    def set_project
      @project = @donation_record.project
    end

    def init_proof
      @donation_record_actual_fund.build_proof
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_record_actual_fund_params
      params.require(:donation_record_actual_fund)
        .permit( :fund_type_id, fund_attributes: [:amount, :time, :comment], proof_attributes: [:file] )
    end
end
