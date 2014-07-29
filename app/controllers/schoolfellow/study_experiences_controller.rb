class Schoolfellow::StudyExperiencesController < ApplicationController
  before_action :set_schoolfellow_study_experience, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:new, :create, :edit, :update, :destroy]
  # GET /schoolfellow/study_experiences
  # GET /schoolfellow/study_experiences.json
  def index
    @schoolfellow_study_experiences = Schoolfellow::StudyExperience.all
  end

  # GET /schoolfellow/study_experiences/1
  # GET /schoolfellow/study_experiences/1.json
  def show
  end

  # GET /schoolfellow/study_experiences/new
  def new
    @schoolfellow_study_experience = Schoolfellow::StudyExperience.new
  end

  # GET /schoolfellow/study_experiences/1/edit
  def edit
  end

  # POST /schoolfellow/study_experiences
  # POST /schoolfellow/study_experiences.json
  def create
    unless @customer.schoolfellow
      @customer.schoolfellow = Schoolfellow.new
      @customer.save!
    end
    @schoolfellow_study_experience = Schoolfellow::StudyExperience.new(schoolfellow_study_experience_params)
    @schoolfellow_study_experience.schoolfellow = @customer.schoolfellow

    respond_to do |format|
      if @schoolfellow_study_experience.save
        format.html { redirect_to @customer, notice: 'Study experience was successfully created.' }
        format.json { render :show, status: :created, location: @schoolfellow_study_experience }
      else
        format.html { render :new }
        format.json { render json: @schoolfellow_study_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schoolfellow/study_experiences/1
  # PATCH/PUT /schoolfellow/study_experiences/1.json
  def update
    respond_to do |format|
      if @schoolfellow_study_experience.update(schoolfellow_study_experience_params)
        format.html { redirect_to @customer, notice: 'Study experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @schoolfellow_study_experience }
      else
        format.html { render :edit }
        format.json { render json: @schoolfellow_study_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schoolfellow/study_experiences/1
  # DELETE /schoolfellow/study_experiences/1.json
  def destroy
    @schoolfellow_study_experience.destroy
    respond_to do |format|
      format.html { redirect_to @customer, notice: 'Study experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schoolfellow_study_experience
      @schoolfellow_study_experience = Schoolfellow::StudyExperience.find(params[:id])
    end
    def set_customer
      @customer = IndividualCustomer.find(params[:individual_customer_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def schoolfellow_study_experience_params
      params.require(:schoolfellow_study_experience).permit(:major_id, :degree_id, 
        :attendance_date, :graduated_date, :student_number)
    end
end
