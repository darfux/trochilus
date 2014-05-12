class DonationTypesController < ApplicationController
  # GET /donation_types
  # GET /donation_types.json
  def index
    @donation_types = DonationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donation_types }
    end
  end

  # GET /donation_types/1
  # GET /donation_types/1.json
  def show
    @donation_type = DonationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donation_type }
    end
  end

  # GET /donation_types/new
  # GET /donation_types/new.json
  def new
    @donation_type = DonationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @donation_type }
    end
  end

  # GET /donation_types/1/edit
  def edit
    @donation_type = DonationType.find(params[:id])
  end

  # POST /donation_types
  # POST /donation_types.json
  def create
    @donation_type = DonationType.new(donation_type_params)

    respond_to do |format|
      if @donation_type.save
        format.html { redirect_to @donation_type, notice: 'Donation type was successfully created.' }
        format.json { render json: @donation_type, status: :created, location: @donation_type }
      else
        format.html { render action: "new" }
        format.json { render json: @donation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donation_types/1
  # PATCH/PUT /donation_types/1.json
  def update
    @donation_type = DonationType.find(params[:id])

    respond_to do |format|
      if @donation_type.update_attributes(donation_type_params)
        format.html { redirect_to @donation_type, notice: 'Donation type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @donation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donation_types/1
  # DELETE /donation_types/1.json
  def destroy
    @donation_type = DonationType.find(params[:id])
    @donation_type.destroy

    respond_to do |format|
      format.html { redirect_to donation_types_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def donation_type_params
      params.require(:donation_type).permit(:name)
    end
end
