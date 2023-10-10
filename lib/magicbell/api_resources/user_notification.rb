module MagicBell
  class UserNotification < ApiResource
    class << self
      def path
        '/notifications'
      end
    end

    def path
      "/notifications/#{id}"
    end

    def mark_as_read(extra_headers = {})
      UserNotificationRead.new(@client, {'user_notification' => self}, extra_headers).create
    end

    def mark_as_unread(extra_headers = {})
      UserNotificationUnread.new(@client, {'user_notification' => self}, extra_headers).create
    end
  end
end
