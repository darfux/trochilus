class FundTypesController < ApplicationController
  # GET /fund_types
  # GET /fund_types.json
  def index
    @fund_types = FundType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fund_types }
    end
  end

  # GET /fund_types/1
  # GET /fund_types/1.json
  def show
    @fund_type = FundType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fund_type }
    end
  end

  # GET /fund_types/new
  # GET /fund_types/new.json
  def new
    @fund_type = FundType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fund_type }
    end
  end

  # GET /fund_types/1/edit
  def edit
    @fund_type = FundType.find(params[:id])
  end

  # POST /fund_types
  # POST /fund_types.json
  def create
    @fund_type = FundType.new(fund_type_params)

    respond_to do |format|
      if @fund_type.save
        format.html { redirect_to @fund_type, notice: 'Fund type was successfully created.' }
        format.json { render json: @fund_type, status: :created, location: @fund_type }
      else
        format.html { render action: "new" }
        format.json { render json: @fund_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fund_types/1
  # PATCH/PUT /fund_types/1.json
  def update
    @fund_type = FundType.find(params[:id])

    respond_to do |format|
      if @fund_type.update_attributes(fund_type_params)
        format.html { redirect_to @fund_type, notice: 'Fund type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fund_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fund_types/1
  # DELETE /fund_types/1.json
  def destroy
    @fund_type = FundType.find(params[:id])
    @fund_type.destroy

    respond_to do |format|
      format.html { redirect_to fund_types_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def fund_type_params
      params.require(:fund_type).permit(:name)
    end
end
