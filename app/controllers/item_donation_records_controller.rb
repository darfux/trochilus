class ItemDonationRecordsController < ApplicationController
  before_action :set_item_donation_record, only: [:show, :edit, :update, :destroy, 
      :new_attachment, :create_attachment, :destroy_attachment]
  before_action :set_project, only: [:show, :new, :create, :edit,  :destroy]
  before_action :set_attachments, only: [:show]
  # GET /item_donation_records
  # GET /item_donation_records.json
  def index
    @item_donation_records = ItemDonationRecord.all
  end

  # GET /item_donation_records/1
  # GET /item_donation_records/1.json
  def show
  end

  # GET /item_donation_records/new
  def new
    @item_donation_record = ItemDonationRecord.new
    @item_donation_record.project = @project
    @form_param = [@item_donation_record.project, @item_donation_record]
  end

  # GET /item_donation_records/1/edit
  def edit
    @form_param = @item_donation_record
  end


  def new_attachment
    @attachment = Attachment.new
  end

  def create_attachment
    @attachment = Attachment.create(attachment_params)
    redirect_to @item_donation_record
  end

  def destroy_attachment
    @attachment = Attachment.find(params[:attachment_id])
    raise 'unmatched donation record' if @item_donation_record != @attachment.owner
    @attachment.destroy
    redirect_to @item_donation_record
  end


  # POST /item_donation_records
  # POST /item_donation_records.json
  def create
    # raise params.inspect
    @item_donation_record = ItemDonationRecord.new(item_donation_record_params)
    @item_donation_record.creator = current_user
    @form_param = [@item_donation_record.project, @item_donation_record]
    respond_to do |format|
      if @item_donation_record.save
        format.html { redirect_to @item_donation_record }
        format.json { render :show, status: :created, location: @item_donation_record }
      else
        format.html { render :new }
        format.json { render json: @item_donation_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_donation_records/1
  # PATCH/PUT /item_donation_records/1.json
  def update
    respond_to do |format|
      if @item_donation_record.update(item_donation_record_params)
        format.html { redirect_to @item_donation_record.project }
        format.json { render :show, status: :ok, location: @item_donation_record }
      else
        format.html { render :edit }
        format.json { render json: @item_donation_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_donation_records/1
  # DELETE /item_donation_records/1.json
  def destroy
    @item_donation_record.destroy
    respond_to do |format|
      format.html { redirect_to @project }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_donation_record
      @item_donation_record = ItemDonationRecord.find(params[:id])
    end

    def set_project
      @project =  (
        if @item_donation_record && @item_donation_record.project
          @item_donation_record.project
        else
          Project.find(params[:project_id])
        end
      )
    end

    def set_attachments
      @attachments = @item_donation_record.attachments
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_donation_record_params
      params.require(:item_donation_record).permit(:customer_id, :project_id, :time)
    end

    def attachment_params
      params.require(:attachment).permit(:file).tap{ |p| p[:attachment_owner]=@item_donation_record }
    end

end
