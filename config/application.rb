require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Trochilus
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/lib/controller)
    config.autoload_paths += %W(#{config.root}/lib/model)
    config.autoload_paths += %W(#{config.root}/lib/extensions)
    config.autoload_paths += %W(#{config.root}/lib/classes)
    config.autoload_paths += %W(#{config.root}/lib/patches)
    config.autoload_paths += %W(#{config.root}/lib/packages)

    config.autoload_once_paths += %W(#{config.root}/lib/packages/package_manager.rb)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :"zh_cn"

    config.assets.paths << "#{Rails.root}/app/assets/stylesheets/employee"

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins 'localhost:3000', '192.168.1.100:8080', 'http://fuxtestwc.sinaapp.com', 'http://nkuef.sinaapp.com'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
