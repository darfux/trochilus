class SchoolfellowsController < ApplicationController
  before_action :set_customer
  def new
    @univ_experience = UnivExperience.new
  end

  def create
    @schoolfellow =  @customer.schoolfellow || (
      @customer.schoolfellow = Schoolfellow.new
      @customer.save
      @customer.schoolfellow
    )
    # raise univ_experience_params.inspect
    @univ_experience = UnivExperience.new(univ_experience_params)
    @univ_experience.schoolfellow = @schoolfellow

    respond_to do |format|
      if  @univ_experience.save
        format.html { redirect_to @customer, notice: '' }
      else
        format.html { render action: 'new' }
        format.json { render json: @univ_experience.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @univ_experience = UnivExperience.find(params[:id])
    @univ_experience.destroy
    if @customer.schoolfellow.univ_experiences.empty?
      @customer.schoolfellow.destroy
    end
    redirect_to @customer
  end
  private
    def set_customer
      @customer = IndividualCustomer.find(params[:individual_customer_id])
    end
    def univ_experience_params
      params.require(:univ_experience).
        permit(:major_id, :degree_id, :univ_unit_id, 
          :attendance_date, :graduated_date, :student_number)
    end
end
