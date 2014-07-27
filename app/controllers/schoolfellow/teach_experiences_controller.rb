class Schoolfellow::TeachExperiencesController < ApplicationController
  before_action :set_schoolfellow_teach_experience, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:new, :create, :edit, :update, :destroy]

  # GET /schoolfellow/teach_experiences
  # GET /schoolfellow/teach_experiences.json
  def index
    @schoolfellow_teach_experiences = Schoolfellow::TeachExperience.all
  end

  # GET /schoolfellow/teach_experiences/1
  # GET /schoolfellow/teach_experiences/1.json
  def show
  end

  # GET /schoolfellow/teach_experiences/new
  def new
    @schoolfellow_teach_experience = Schoolfellow::TeachExperience.new
  end

  # GET /schoolfellow/teach_experiences/1/edit
  def edit
  end

  # POST /schoolfellow/teach_experiences
  # POST /schoolfellow/teach_experiences.json
  def create
    unless @customer.schoolfellow
      @customer.schoolfellow = Schoolfellow.new
      @customer.save!
    end
    @schoolfellow_teach_experience = Schoolfellow::TeachExperience.new(schoolfellow_teach_experience_params)
    @schoolfellow_teach_experience.schoolfellow = @customer.schoolfellow


    respond_to do |format|
      if @schoolfellow_teach_experience.save
        format.html { redirect_to @customer, notice: 'Teach experience was successfully created.' }
        format.json { render :show, status: :created, location: @schoolfellow_teach_experience }
      else
        format.html { render :new }
        format.json { render json: @schoolfellow_teach_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schoolfellow/teach_experiences/1
  # PATCH/PUT /schoolfellow/teach_experiences/1.json
  def update
    respond_to do |format|
      if @schoolfellow_teach_experience.update(schoolfellow_teach_experience_params)
        format.html { redirect_to @customer, notice: 'Teach experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @schoolfellow_teach_experience }
      else
        format.html { render :edit }
        format.json { render json: @schoolfellow_teach_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schoolfellow/teach_experiences/1
  # DELETE /schoolfellow/teach_experiences/1.json
  def destroy
    @schoolfellow_teach_experience.destroy
    respond_to do |format|
      format.html { redirect_to @customer, notice: 'Teach experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schoolfellow_teach_experience
      @schoolfellow_teach_experience = Schoolfellow::TeachExperience.find(params[:id])
    end

    def set_customer
      @customer = IndividualCustomer.find(params[:individual_customer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schoolfellow_teach_experience_params
      params.require(:schoolfellow_teach_experience).permit(:teacher_title_id, :univ_unit_id, :teach_start, :teach_end, :idnum)
    end
end
