class UsageRecordsController < ApplicationController
  # GET /usage_records
  # GET /usage_records.json
  def index
    @usage_records = UsageRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usage_records }
    end
  end

  # GET /usage_records/1
  # GET /usage_records/1.json
  def show
    @usage_record = UsageRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usage_record }
    end
  end

  # GET /usage_records/new
  # GET /usage_records/new.json
  def new
    @usage_record = UsageRecord.new
    @usage_record.project_id = params[:project]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usage_record }
    end
  end

  # GET /usage_records/1/edit
  def edit
    @usage_record = UsageRecord.find(params[:id])
  end

  # POST /usage_records
  # POST /usage_records.json
  def create
    @usage_record = UsageRecord.new(usage_record_params)

    respond_to do |format|
      if @usage_record.save
        format.html { redirect_to project_path(@usage_record.project_id), notice: 'Usage record was successfully created.' }
        format.json { render json: @usage_record, status: :created, location: @usage_record }
      else
        format.html { render action: "new" }
        format.json { render json: @usage_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usage_records/1
  # PATCH/PUT /usage_records/1.json
  def update
    @usage_record = UsageRecord.find(params[:id])

    respond_to do |format|
      if @usage_record.update_attributes(usage_record_params)
        format.html { redirect_to @usage_record, notice: 'Usage record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usage_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usage_records/1
  # DELETE /usage_records/1.json
  def destroy
    @usage_record = UsageRecord.find(params[:id])
    @usage_record.destroy

    respond_to do |format|
      format.html { redirect_to usage_records_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def usage_record_params
      params.require(:usage_record)
        .permit(  :customer_id, :project_id, :exec_unit_id, :exec_manager_id, 
                  :benefit_unit_id, :benefit_manager_id,:usage_type_id,
                  fund_attributes: [:amount, :time, :fund_type_id]
                  )
        .tap{ |p| 
          p[:employee_id] = @current_user.id
        }
    end
end
