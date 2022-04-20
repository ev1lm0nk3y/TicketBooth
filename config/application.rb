# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(:default, Rails.env)
end

# @description Main Application Class for the Ticket Booth
module TicketBooth
  class Application < ::Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    config.active_record.schema_format = :sql

    config.active_record.raise_in_transactional_callbacks = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Force application to not access DB or load models when precompiling assets
    config.assets.initialize_on_precompile = false

    # HACK: During asset compilation of a deploy this will fail because Rails will
    # start up but the config file hasn't been symlinked yet. To prevent a blowup,
    # we check for the existence of the file before trying to load it.
    config_file = "#{Rails.root}/config/smtp.yml"

    if File.exist?(config_file)
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.perform_deliveries = true

      smtp_config = YAML.load_file(config_file)
      config.action_mailer.smtp_settings = %w[address port user_name password]
                                           .each_with_object({}) do |key, hash|
        hash[key.to_sym] = smtp_config[key]
      end
    end
  end
end
