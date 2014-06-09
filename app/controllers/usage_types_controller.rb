class UsageTypesController < ApplicationController
  # GET /usage_types
  # GET /usage_types.json
  def index
    @usage_types = UsageType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usage_types }
    end
  end

  # GET /usage_types/1
  # GET /usage_types/1.json
  def show
    @usage_type = UsageType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usage_type }
    end
  end

  # GET /usage_types/new
  # GET /usage_types/new.json
  def new
    @usage_type = UsageType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usage_type }
    end
  end

  # GET /usage_types/1/edit
  def edit
    @usage_type = UsageType.find(params[:id])
  end

  # POST /usage_types
  # POST /usage_types.json
  def create
    @usage_type = UsageType.new(usage_type_params)

    respond_to do |format|
      if @usage_type.save
        format.html { redirect_to @usage_type, notice: 'Usage type was successfully created.' }
        format.json { render json: @usage_type, status: :created, location: @usage_type }
      else
        format.html { render action: "new" }
        format.json { render json: @usage_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usage_types/1
  # PATCH/PUT /usage_types/1.json
  def update
    @usage_type = UsageType.find(params[:id])

    respond_to do |format|
      if @usage_type.update_attributes(usage_type_params)
        format.html { redirect_to @usage_type, notice: 'Usage type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usage_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usage_types/1
  # DELETE /usage_types/1.json
  def destroy
    @usage_type = UsageType.find(params[:id])
    @usage_type.destroy

    respond_to do |format|
      format.html { redirect_to usage_types_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def usage_type_params
      params.require(:usage_type).permit(:name)
    end
end
