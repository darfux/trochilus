class PackageManager
  @used_packages = {}
  class << self
    attr_reader :used_packages
    def use(*packages)
      packages.each do |package|
        return nil if @used_packages[package.to_sym]
        package.to_s.constantize.tap do |p|
          p.use
          @used_packages[package.to_sym] = true
        end
      end
    end
  end
end