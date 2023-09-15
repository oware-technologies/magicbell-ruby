module MagicBell
  class UserPushSubscription < ApiResource
    class << self
      def path
        '/push_subscriptions'
      end
    end

    def path
      "/push_subscriptions/#{id}"
    end
  end
end
