class ActualFundsController < FundsController
  before_action :set_donation_record_actual, only: [:new, :create]
  # def show
  # end

  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new(fund_params)
    @fund.donation_record_actual = @donation_record_actual
    # raise @donation_record_actual.inspect
    # raise "!" if @donation_record_actual.nil?
    respond_to do |format|
      if @fund.save
        format.html { redirect_to @fund, notice: 'Fund was successfully created.' }
        format.json { render json: @fund, status: :created, location: @fund }
      else
        format.html { render action: "new" }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  # end

  # def destroy
  # end
  private
    def set_donation_record_actual
      @donation_record_actual = DonationRecord.find(params[:donation_record_id])
    end
end
