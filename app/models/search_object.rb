class SearchObject < ActiveRecord::Base
  has_no_table
  column :type, :string
  column :query, :string
  auto_strip_attributes :query
  validates_presence_of :type, :query
end