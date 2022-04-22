# frozen_string_literal: true

TicketBooth::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  ### MM: Modified for Kubernetes
  config.serve_static_files = true

  # Compress CSS and JavaScripts
  config.assets.css_compressor = :sass
  config.assets.js_compressor = :uglifier

  # Don't fallback to assets pipeline if a precompiled asset is missed
  ### MM: Modified for Kubernetes
  ## FIXME: Why doe we need this if we compile assets in the container build? 
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  ### MM: Modified for Kubernetes
  config.force_ssl = false

  # See everything in the log (default is :info)
  config.log_level = :debug

  # Prepend all log lines with the following tags
  config.log_tags = [->(_req) { DateTime.now }, :uuid]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = { host: 'tickets.com' }
  config.action_mailer.raise_delivery_errors = false

  # FIXME: Why?
  # pg_dump doesnt seem to work in the container in Kubernetes, 
  # it works on docker-compose. Why do we need it? 
  # https://stackoverflow.com/questions/41561883/pg-dump-error-while-running-rake-dbmigrate
  config.active_record.dump_schema_after_migration = false

end
