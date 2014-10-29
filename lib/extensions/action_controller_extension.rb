module ActionControllerExtension
  module Inner
    include ModelFilterControllerExtension
  end
  include InnerForAllSubclass
end