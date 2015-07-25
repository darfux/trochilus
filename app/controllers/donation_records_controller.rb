class DonationRecordsController < ApplicationController
  before_action :set_donation_record, only: [:show, :edit, :update, :destroy,
    :new_attachment, :create_attachment, :destroy_attachment, :trans_undetermined_in, :handle_undetermined_trans]
  before_action :set_project, only: [:show, :new, :create, :edit,  :destroy, :trans_undetermined_in]
  before_action :set_attachments, only: [:show]
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
    @donation_record.project = @project
    @form_param = [@donation_record.project, @donation_record]
  end

  # GET /donation_records/1/edit
  def edit
    @form_param = @donation_record
  end

  # POST /donation_records
  # POST /donation_records.json
  def create
    @donation_record = DonationRecord.new(donation_record_params)
    fund_amount = donation_record_params[:fund_attributes][:amount]
    autofund = OpenStruct.new("save!" => true)
    if fund_amount.to_i != 0
      autofund = DonationRecord::ActualFund.new(fund_type_id: FundType.principle_id, fund_attributes: donation_record_params[:fund_attributes])
      @donation_record.actual_funds << autofund
    end

    @donation_record.creator = current_user
    @form_param = [@donation_record.project, @donation_record]

    # @donation_record.transaction do
    #   @donation_record.save!
    #   autofund.save!
    respond_to do |format|
      if @donation_record.save
        format.html { redirect_to @project }
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
    @form_param = @donation_record
    respond_to do |format|
      if @donation_record.update(donation_record_params)
        format.html { redirect_to @donation_record.project }
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
      format.html { redirect_to @project }
      format.json { head :no_content }
    end
  end

  def new_attachment
    @attachment = Attachment.new
  end

  def create_attachment
    @attachment = Attachment.create(attachment_params)
    redirect_to @donation_record
  end

  def destroy_attachment
    @attachment = Attachment.find(params[:attachment_id])
    raise 'unmatched donation record' if @donation_record != @attachment.owner
    @attachment.destroy
    redirect_to @donation_record
  end

  def trans_undetermined_in
    @undetermined_funds = Fund.select_by_type(Fund.poly_types.undetermined).handle_filter(current_filter)
  end

  def handle_undetermined_trans
    fund = Fund.find(params[:undetermined_fund])
    if fund.fund_instance_type == UndeterminedFund.to_s
      ufund = UndeterminedFund.find(fund.fund_instance_id)
      af = DonationRecord::ActualFund.new(
        fund: fund, donation_record: @donation_record, fund_type_id: FundType.principle_id, serialnum: "")
      respond_to do |format|
        if af.save
          ufund.destroy
          format.html { redirect_to @donation_record }
          format.json { render :show, status: :ok, location: af }
        else
          format.html { render :wrong_undetermined_fund }
          format.json { render json: af.errors, status: :unprocessable_entity }
        end
      end
    else
      raise 'unmatched undetermined fund'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_record
      @donation_record = DonationRecord.find(params[:id])
    end

    def set_attachments
      @attachments = @donation_record.attachments()
    end

    def set_project
      @project =  (
        if @donation_record && @donation_record.project
          @donation_record.project
        else
          Project.find(params[:project_id])
        end
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_record_params
      params.require(:donation_record)
        .permit(  :customer_id, :project_id, :donation_type_id,
                  fund_attributes: [:time, :comment, :currency_id, :origin_amount, :amount]
                  ).tap{ |p| p[:fund_attributes][:amount].blank? ? p[:fund_attributes][:amount] = '0' : nil }
    end
    def attachment_params
      params.require(:attachment).permit(:file).tap{ |p| p[:attachment_owner]=@donation_record }
    end
end
