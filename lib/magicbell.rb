require 'forwardable'

require 'openssl'
require 'base64'

require 'magicbell/config'

require 'httparty'
require 'magicbell/api_operations'
require 'magicbell/client'
require 'magicbell/api_resource'
require 'magicbell/singleton_api_resource'
require 'magicbell/api_resource_collection'
require 'magicbell/api_resources/notification'
require 'magicbell/api_resources/user'
require 'magicbell/api_resources/user_notification'
require 'magicbell/api_resources/user_notifications'
require 'magicbell/api_resources/user_notification_read'
require 'magicbell/api_resources/user_notification_unread'
require 'magicbell/api_resources/user_notifications_read'
require 'magicbell/api_resources/user_notifications_seen'
require 'magicbell/api_resources/user_notification_preferences'
require 'magicbell/api_resources/push_subscription'

require 'magicbell/railtie' if defined?(Rails)

module MagicBell
  class << self
    extend Forwardable

    def_delegators :config, :api_key, :api_secret, :api_host

    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end

    def reset_config
      @config = Config.new
    end

    def authentication_headers(client_api_key: nil, client_api_secret: nil)
      {
        'X-MAGICBELL-API-KEY' => client_api_key || api_key,
        'X-MAGICBELL-API-SECRET' => client_api_secret || api_secret
      }
    end

    # Calculate HMAC for user's email
    def hmac(message)
      MagicBell::Client.new(api_key: api_key, api_secret: api_secret).hmac(message)
    end
  end
end
