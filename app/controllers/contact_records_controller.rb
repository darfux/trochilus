class ContactRecordsController < ApplicationController
  before_action :set_contact_record, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:new, :show, :edit, :update, :create, :destroy]

  # GET /contact_records
  # GET /contact_records.json
  def index
    @contact_records = ContactRecord.all
  end

  # GET /contact_records/1
  # GET /contact_records/1.json
  def show
  end

  # GET /contact_records/new
  def new
    @contact_record = ContactRecord.new
  end

  # GET /contact_records/1/edit
  def edit
  end

  # POST /contact_records
  # POST /contact_records.json
  def create
    @contact_record = ContactRecord.new(contact_record_params)

    respond_to do |format|
      if @contact_record.save
        format.html { redirect_to @customer, notice: 'Contact record was successfully created.' }
        format.json { render :show, status: :created, location: @contact_record }
      else
        format.html { render :new }
        format.json { render json: @contact_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_records/1
  # PATCH/PUT /contact_records/1.json
  def update
    respond_to do |format|
      if @contact_record.update(contact_record_params)
        format.html { redirect_to @customer, notice: 'Contact record was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact_record }
      else
        format.html { render :edit }
        format.json { render json: @contact_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_records/1
  # DELETE /contact_records/1.json
  def destroy
    @contact_record.destroy
    respond_to do |format|
      format.html { redirect_to contact_records_url, notice: 'Contact record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_record
      @contact_record = ContactRecord.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_record_params
      params.require(:contact_record).permit(:time, :location, :description, :conclusion).tap{ |p|
        p[:creator_id] = current_user.id
        p[:customer_id] = params[:customer_id]
      }
    end
end
