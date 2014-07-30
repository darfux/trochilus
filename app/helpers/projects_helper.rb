module ProjectsHelper
  def show_manager
    link_to @project.create_manager.name, @project.create_manager if @project.create_manager
  end
end
