class Project::NewsController < ApplicationController
  before_action :set_project_news, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create, :new, :edit, :destroy]
  # GET /project/news
  # GET /project/news.json
  def index
    @project_news = Project::News.all
  end

  # GET /project/news/1
  # GET /project/news/1.json
  def show
  end

  # GET /project/news/new
  def new
    @project_news = Project::News.new
  end

  # GET /project/news/1/edit
  def edit
  end

  # POST /project/news
  # POST /project/news.json
  def create
    @project_news = Project::News.new(project_news_params)

    respond_to do |format|
      if @project_news.save
        format.html { redirect_to @project, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @project_news }
      else
        format.html { render :new }
        format.json { render json: @project_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project/news/1
  # PATCH/PUT /project/news/1.json
  def update
    respond_to do |format|
      if @project_news.update(project_news_params)
        format.html { redirect_to @project_news.project, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_news }
      else
        format.html { render :edit }
        format.json { render json: @project_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project/news/1
  # DELETE /project/news/1.json
  def destroy
    @project_news.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_news
      @project_news = Project::News.find(params[:id])
    end

    def set_project
      @project = (@project_news && @project_news.project) || Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_news_params
      params.require(:project_news).permit(:title, :link, :comment).tap{ |p|
        p[:project_id] = @project.id
      }
    end
end
