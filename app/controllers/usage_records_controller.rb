class UsageRecordsController < ApplicationController
  before_action :set_usage_record, only: [:show, :edit, :update, :destroy,
    :new_attachment, :create_attachment, :destroy_attachment]
  before_action :set_project, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_attachments, only: [:show]
  # GET /usage_records
  # GET /usage_records.json
  def index
    @usage_records = UsageRecord.all
  end

  # GET /usage_records/1
  # GET /usage_records/1.json
  def show
  end

  # GET /usage_records/new
  def new
    @usage_record = UsageRecord.new
    @usage_record.project = Project.find(params[:project_id])
  end

  # GET /usage_records/1/edit
  def edit
  end

  # POST /usage_records
  # POST /usage_records.json
  def create
    @usage_record = UsageRecord.new(usage_record_params)
    @usage_record.tap{ |u| 
      u.principle_fund = nil unless params[:use] && params[:use][:principle]
      u.interest_fund = nil unless params[:use] && params[:use][:interest]
    }
    respond_to do |format|
      if @usage_record.save
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @usage_record }
      else
        format.html { render :new }
        format.json { render json: @usage_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usage_records/1
  # PATCH/PUT /usage_records/1.json
  def update
    respond_to do |format|
      if @usage_record.update(usage_record_params)
        format.html { redirect_to @project }
        format.json { render :show, status: :ok, location: @usage_record }
      else
        format.html { render :edit }
        format.json { render json: @usage_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usage_records/1
  # DELETE /usage_records/1.json
  def destroy
    @usage_record.destroy
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
    redirect_to @usage_record
  end

  def destroy_attachment
    @attachment = Attachment.find(params[:attachment_id])
    raise 'unmatched donation record' if @usage_record != @attachment.owner
    @attachment.destroy
    redirect_to @usage_record
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usage_record
      @usage_record = UsageRecord.find(params[:id])
    end

    def set_attachments
      @attachments = @usage_record.attachments
    end

    def set_project
      @project =  (
        if @usage_record && @usage_record.project
          @usage_record.project
        else
          Project.find(params[:project_id])
        end
      )
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def usage_record_params
      params.require(:usage_record)
      .permit(:customer_id, :project_id, :exec_unit_id, :exec_manager_id, 
              :benefit_unit_id, :benefit_manager_id,:usage_type_id,
              interest_fund_attributes: [fund_attributes: [:amount]],
              principle_fund_attributes: [fund_attributes: [:amount]]
              )
        .tap{ |p|
        p[:creator_id] = current_user.id
        p[:project_id] = params[:project_id]
        p[:interest_fund_attributes] && p[:interest_fund_attributes][:fund_attributes].merge!(params[:fund_time])
        p[:principle_fund_attributes][:fund_attributes].merge! params[:fund_time]
      }
    end

    def attachment_params
      params.require(:attachment).permit(:file).tap{ |p| p[:attachment_owner]=@usage_record }
    end
end
