class Attachment < ActiveRecord::Base
  belongs_to :attachment_owner, polymorphic: true
  has_attached_file :file
  do_not_validate_attachment_file_type :file
  validates :file, :attachment_presence => true
  
  alias_attribute :filename, :file_file_name #don't use alias or alias_method which will cause exception
  alias_attribute :owner, :attachment_owner #don't use alias or alias_method which will cause exception
end
