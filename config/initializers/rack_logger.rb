module Rails
  module Rack
    # Sets log tags, logs the request, calls the app, and flushes the logs.
    class Logger < ActiveSupport::LogSubscriber
      alias_method :org_started_request_message, :started_request_message 
      def started_request_message(request)
        l = org_started_request_message(request)
        l + %Q{ -ref-"#{request.referer}" -agent-"#{request.env["HTTP_USER_AGENT"]}" -accept-"#{request.env["HTTP_ACCEPT"]}"}
      end
    end
  end
end