class UsageRecordsController < ApplicationController
  before_action :set_usage_record, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create, :edit, :update, :destroy]

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

    respond_to do |format|
      if @usage_record.save
        format.html { redirect_to @project, notice: 'Usage record was successfully created.' }
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
        format.html { redirect_to @project, notice: 'Usage record was successfully updated.' }
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
      format.html { redirect_to @project, notice: 'Usage record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usage_record
      @usage_record = UsageRecord.find(params[:id])
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
              :benefit_unit_id, :benefit_manager_id,:usage_type_id, :fund_type_id,
              fund_attributes: [:amount, :time]
              )
        .tap{ |p|
        p[:creator_id] = current_user.id
        p[:project_id] = params[:project_id]
      }
    end
end
