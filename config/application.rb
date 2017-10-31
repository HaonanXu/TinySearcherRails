require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TinySearcher
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.cache_store = :redis_store, "redis://#{ENV.fetch('REDIS_HOST', 'localhost')}:6379/0/cache", { expires_in: 90.minutes }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.test_framework :rspec, :fixture => true
      g.fixture_replacement :factory_bot, :dir => "spec/factories"
    end

    config.searcher = config_for(:searcher)
  end
end
