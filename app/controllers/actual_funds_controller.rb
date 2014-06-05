class ActualFundsController < ApplicationController
  before_action :set_donation_record_actual, only: [:new, :create, :edit, :update]
  def show
    @fund = ActualFund.find(params[:id])
  end

  def new
    @fund = ActualFund.new
  end
  def edit
    @fund = ActualFund.find(params[:id])
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
    @fund = Fund.find(params[:id])

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
    def set_donation_record_actual
      @donation_record_actual = DonationRecord.find(params[:donation_record_id])
    end
    def fund_params
      params.require(:actual_fund).permit(:amount, :comment, :fund_type_id, :time)
    end
end
