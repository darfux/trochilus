class IndividualCustomersController < CommonCustomersController
  before_action :set_school_fellow
  before_action :set_experiences
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiences
      @study_experiences = @schoolfellow ? @schoolfellow.study_experiences.order(:attendance_date) : []
      @teach_experiences = @schoolfellow ? @schoolfellow.teach_experiences.order(:teach_start) : []
    end
    def set_school_fellow
      @schoolfellow = @self_customer ?  @self_customer.schoolfellow : nil 
    end
    def self_params
      sp = super
      if params[:is_schoolfellow]
        sp[:schoolfellow_attributes] = {}
        sp.merge params.require(@SelfType).permit(schoolfellow_attributes:[])
      end
      sp
    end
end
