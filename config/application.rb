require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Courts
  class Application < Rails::Application
    config.assets.initialize_on_precompile = false
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brussels'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :fr

    #configuration Mailjet
    #config.action_mailer.delivery_method = :mailjet

    config.autoload_paths += %W(#{config.root}/lib)
  end
end
