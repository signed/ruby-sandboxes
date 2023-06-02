require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative '../lib/focused_formatter'

module RailsApiApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # https://logger.rocketjob.io/rails
    # https://github.com/reidmorrison/rails_semantic_logger/issues/117
    $stdout.sync = true
    config.rails_semantic_logger.add_file_appender = false
    config.rails_semantic_logger.format = FocusedFormatter.new
    config.semantic_logger.add_appender(io: $stdout, level: config.log_level, formatter: config.rails_semantic_logger.format)
    #config.rails_semantic_logger.started = false
    #config.rails_semantic_logger.processing = false
    #config.rails_semantic_logger.rendered = false
    #config.rails_semantic_logger.quiet_assets = true

    config.log_tags = {
      request_id: :request_id
    }
  end
end
