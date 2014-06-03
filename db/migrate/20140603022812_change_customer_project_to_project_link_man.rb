class ChangeCustomerProjectToProjectLinkMan < ActiveRecord::Migration
  def up
    rename_table(:customer_projects, :project_link_men)
  end

  def down
    rename_table(:project_link_men, :customer_projects)
  end
end
