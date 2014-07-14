class DonationRecordsController < ApplicationController
  before_action :set_donation_record, only: [:show, :edit, :update, :destroy]

  # GET /donation_records
  # GET /donation_records.json
  def index
    @donation_records = DonationRecord.all
  end

  # GET /donation_records/1
  # GET /donation_records/1.json
  def show
  end

  # GET /donation_records/new
  def new
    @donation_record = DonationRecord.new
  end

  # GET /donation_records/1/edit
  def edit
  end

  # POST /donation_records
  # POST /donation_records.json
  def create
    @donation_record = DonationRecord.new(donation_record_params)

    respond_to do |format|
      if @donation_record.save
        format.html { redirect_to @donation_record, notice: 'Donation record was successfully created.' }
        format.json { render :show, status: :created, location: @donation_record }
      else
        format.html { render :new }
        format.json { render json: @donation_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donation_records/1
  # PATCH/PUT /donation_records/1.json
  def update
    respond_to do |format|
      if @donation_record.update(donation_record_params)
        format.html { redirect_to @donation_record, notice: 'Donation record was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation_record }
      else
        format.html { render :edit }
        format.json { render json: @donation_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donation_records/1
  # DELETE /donation_records/1.json
  def destroy
    @donation_record.destroy
    respond_to do |format|
      format.html { redirect_to donation_records_url, notice: 'Donation record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_record
      @donation_record = DonationRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_record_params
      params.require(:donation_record).permit(:customer_id, :project_id, :creator_id, :plan_fund_id, :donation_type_id)
    end
end
