class TeacherTitlesController < ApplicationController
  before_action :set_teacher_title, only: [:show, :edit, :update, :destroy]

  # GET /teacher_titles
  # GET /teacher_titles.json
  def index
    @teacher_titles = TeacherTitle.all
  end

  # GET /teacher_titles/1
  # GET /teacher_titles/1.json
  def show
  end

  # GET /teacher_titles/new
  def new
    @teacher_title = TeacherTitle.new
  end

  # GET /teacher_titles/1/edit
  def edit
  end

  # POST /teacher_titles
  # POST /teacher_titles.json
  def create
    @teacher_title = TeacherTitle.new(teacher_title_params)

    respond_to do |format|
      if @teacher_title.save
        format.html { redirect_to @teacher_title, notice: 'Teacher title was successfully created.' }
        format.json { render :show, status: :created, location: @teacher_title }
      else
        format.html { render :new }
        format.json { render json: @teacher_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teacher_titles/1
  # PATCH/PUT /teacher_titles/1.json
  def update
    respond_to do |format|
      if @teacher_title.update(teacher_title_params)
        format.html { redirect_to @teacher_title, notice: 'Teacher title was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher_title }
      else
        format.html { render :edit }
        format.json { render json: @teacher_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher_titles/1
  # DELETE /teacher_titles/1.json
  def destroy
    @teacher_title.destroy
    respond_to do |format|
      format.html { redirect_to teacher_titles_url, notice: 'Teacher title was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_title
      @teacher_title = TeacherTitle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_title_params
      params.require(:teacher_title).permit(:name)
    end
end
