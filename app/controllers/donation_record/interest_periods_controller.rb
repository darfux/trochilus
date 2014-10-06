class DonationRecord::InterestPeriodsController < ApplicationController
  before_action :set_donation_record_interest_period, only: [:show, :edit, :update, :destroy]
  before_action :set_donation_record, only: [:show, :edit, :create, :update, :destroy]

  def index
    @donation_record_interest_periods = DonationRecord::InterestPeriod.all
  end

  def show
  end

  def new
    @donation_record_interest_period = DonationRecord::InterestPeriod.new
  end

  def edit
  end

  def create
    @donation_record_interest_period = DonationRecord::InterestPeriod.new(donation_record_interest_period_params)

    respond_to do |format|
      if @donation_record_interest_period.save
        format.html { redirect_to @donation_record, notice: 'Interest period was successfully created.' }
        format.json { render :show, status: :created, location: @donation_record_interest_period }
      else
        format.html { render :new }
        format.json { render json: @donation_record_interest_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @donation_record_interest_period.update(donation_record_interest_period_params)
        format.html { redirect_to @donation_record, notice: 'Interest period was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation_record_interest_period }
      else
        format.html { render :edit }
        format.json { render json: @donation_record_interest_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @donation_record_interest_period.destroy
    respond_to do |format|
      format.html { redirect_to @donation_record, notice: 'Interest period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_record_interest_period
      @donation_record_interest_period = DonationRecord::InterestPeriod.find(params[:id])
    end

    def set_donation_record
      @donation_record = (@donation_record_interest_period && @donation_record_interest_period.donation_record) || 
        DonationRecord.find(params[:donation_record_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_record_interest_period_params
      params.require(:donation_record_interest_period).permit(:rate, :start, :end, :comment).tap{ |p|
        p[:donation_record_id] = @donation_record.id
      }
    end
end
