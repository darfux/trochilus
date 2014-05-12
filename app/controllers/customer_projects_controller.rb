class CustomerProjectsController < ApplicationController
  # GET /customer_projects
  # GET /customer_projects.json
  def index
    @customer_projects = CustomerProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_projects }
    end
  end

  # GET /customer_projects/1
  # GET /customer_projects/1.json
  def show
    @customer_project = CustomerProject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer_project }
    end
  end

  # GET /customer_projects/new
  # GET /customer_projects/new.json
  def new
    @customer_project = CustomerProject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer_project }
    end
  end

  # GET /customer_projects/1/edit
  def edit
    @customer_project = CustomerProject.find(params[:id])
  end

  # POST /customer_projects
  # POST /customer_projects.json
  def create
    @customer_project = CustomerProject.new(customer_project_params)

    respond_to do |format|
      if @customer_project.save
        format.html { redirect_to @customer_project, notice: 'Customer project was successfully created.' }
        format.json { render json: @customer_project, status: :created, location: @customer_project }
      else
        format.html { render action: "new" }
        format.json { render json: @customer_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_projects/1
  # PATCH/PUT /customer_projects/1.json
  def update
    @customer_project = CustomerProject.find(params[:id])

    respond_to do |format|
      if @customer_project.update_attributes(customer_project_params)
        format.html { redirect_to @customer_project, notice: 'Customer project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_projects/1
  # DELETE /customer_projects/1.json
  def destroy
    @customer_project = CustomerProject.find(params[:id])
    @customer_project.destroy

    respond_to do |format|
      format.html { redirect_to customer_projects_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def customer_project_params
      params.require(:customer_project).permit(:customer_id, :project_id)
    end
end
