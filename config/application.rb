require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstaClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # redisのための設定
    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
    # i18nのための設定
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.generators do |g|
      g.assets false          # CSS/JSファイルを生成しない
      g.skip_routes false     # trueなら routes.rbを変更する
      g.test_framework false  # テストファイルを作成しない
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
