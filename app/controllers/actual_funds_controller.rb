class ActualFundsController < ApplicationController
  before_action :set_actual_fund, only: [:show, :edit, :update, :destroy]
  before_action :set_donation_record_actual, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :edit, :update]

  def show
  end

  def new
    @fund = ActualFund.new
    @fund.donation_record = @donation_record_actual

    unless @donation_record_actual.project.endowment
      @fund.fund_type = FundType.where(name: '本金').first
    end
  end

  def edit
  end

  def create
    @fund = ActualFund.new(fund_params)
    @fund.donation_record_actual = @donation_record_actual

    # raise @donation_record_actual.inspect
    # raise "!" if @donation_record_actual.nil?
    respond_to do |format|
      if @fund.save
        format.html { redirect_to @donation_record_actual, notice: 'Fund was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fund.update_attributes(fund_params)
        format.html { redirect_to @donation_record_actual, notice: 'Fund was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actual_fund
      @fund = ActualFund.find(params[:id])
    end

    def set_donation_record_actual
      @donation_record_actual =  (
        if @fund && @fund.donation_record
          @fund.donation_record
        else
          DonationRecord.find(params[:donation_record_id])
        end
      )
    end

    def set_project
      @project = @donation_record_actual.project
    end

    def fund_params
      params.require(:actual_fund).permit(:amount, :comment, :fund_type_id, :time)
    end
end
