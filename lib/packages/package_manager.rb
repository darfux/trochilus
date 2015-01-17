class PackageManager
  @used_packages = {}
  @auto_run_tasks = []
  # @used_helpers = []
  # module Helpers
  #   def self.included(r)
  #     r.send(:include, *PackageManager.used_helpers)
  #   end
  # end
  class << self
    attr_reader :used_packages, :auto_run_tasks
    def use(*packages)
      packages.each do |package|
        return nil if @used_packages[package.to_sym]
        package.to_s.constantize.tap do |p|
          p.use
          # if h=(p.const_get(:ViewHelpers) rescue nil)
          #   @used_helpers << h.to_s
          # end
          @used_packages[package.to_sym] = true
        end
      end
    end
    def auto_run_when_reload(&block)
      @auto_run_tasks.push block
    end
    # def used_helpers
    #   @used_helpers.collect { |e| e.constantize } # use constantize to get the reloaded const
    # end
  end
  module AutoExcute
    module Inner
      def self.included(r)
        PackageManager.auto_run_tasks.each do |task|
          task.call()
        end
      end
    end
    include InnerForAllSubclass
  end
  ActionController::Base.send(:include, AutoExcute)
end