require_dependency "active_record_extension"
require_dependency "date_extension"
require_dependency "array_relation"
require_dependency "hash_direct_fetch_extension"
require_dependency "model_filter"
require_dependency "form_builder_extension"

ActiveRecord::Base.send(:include, ModelFilterActiveRecordExtension)
require_dependency "model_filter_controller_extension"