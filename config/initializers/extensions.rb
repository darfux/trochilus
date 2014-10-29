require "date_extension"
require "array_relation"
require "hash_direct_fetch_extension"
require "form_builder_extension"

ActiveRecord::Base.send(:include, ActiveRecordExtension)
ActionController::Base.send(:include, ActionControllerExtension)
