class DonationRecordsController < ApplicationController
  # GET /donation_records
  # GET /donation_records.json
  def index
    @donation_records = DonationRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donation_records }
    end
  end

  # GET /donation_records/1
  # GET /donation_records/1.json
  def show
    @donation_record = DonationRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donation_record }
    end
  end

  # GET /donation_records/new
  # GET /donation_records/new.json
  def new
    @donation_record = DonationRecord.new
    @donation_record.project_id = params[:project]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @donation_record }
    end
  end

  # GET /donation_records/1/edit
  def edit
    @donation_record = DonationRecord.find(params[:id])
  end

  # POST /donation_records
  # POST /donation_records.json
  def create
    @donation_record = DonationRecord.new(donation_record_params)
    @donation_record.donation_type = DonationType.first
    
    respond_to do |format|
      if @donation_record.save
        format.html { redirect_to project_path(@donation_record.project_id), notice: 'Donation record was successfully created.' }
        # format.json { render json: @donation_record, status: :created, location: @donation_record }
      else
        format.html { render action: "new" }
        format.json { render json: @donation_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donation_records/1
  # PATCH/PUT /donation_records/1.json
  def update
    @donation_record = DonationRecord.find(params[:id])

    respond_to do |format|
      if @donation_record.update_attributes(donation_record_params)
        format.html { redirect_to @donation_record, notice: 'Donation record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @donation_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donation_records/1
  # DELETE /donation_records/1.json
  def destroy
    @donation_record = DonationRecord.find(params[:id])
    @donation_record.destroy

    respond_to do |format|
      format.html { redirect_to donation_records_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def donation_record_params
      params.require(:donation_record)
        .permit(  :customer_id, :project_id,
                  fund_attributes: [:amount, :time]
                  )
        .tap{ |p| 
          p[:employee_id] = @current_user.id
        }
    end
end
