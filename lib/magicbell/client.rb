module MagicBell
  class Client
    class HTTPError < StandardError
      attr_accessor :response_status,
                    :response_headers,
                    :response_body,
                    :errors
    end

    include ApiOperations

    def initialize(api_key: nil, api_secret: nil)
      @api_key = api_key
      @api_secret = api_secret
    end

    def create_notification(notification_attributes)
      MagicBell::Notification.create(self, notification_attributes)
    end

    def user_with_email(email)
      client = self
      MagicBell::User.new(client, 'email' => email)
    end

    def user_with_external_id(external_id)
      client = self
      MagicBell::User.new(client, 'external_id' => external_id)
    end

    def create_push_subscription(push_subscription_attributes, extra_headers)
      MagicBell::PushSubscription.create(self, push_subscription_attributes, extra_headers)
    end

    def delete_push_subscription(push_subscription_attributes, extra_headers)
      MagicBell::UserPushSubscription.delete(self, push_subscription_attributes, extra_headers)
    end

    def authentication_headers
      MagicBell.authentication_headers(client_api_key: @api_key, client_api_secret: @api_secret)
    end

    def hmac(message)
      secret = @api_secret || MagicBell.api_secret
      digest = OpenSSL::HMAC.digest(sha256_digest, secret, message)

      Base64.encode64(digest).strip
    end

    private

    def sha256_digest
      OpenSSL::Digest.new('sha256')
    end
  end
end
