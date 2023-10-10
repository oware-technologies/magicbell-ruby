module MagicBell
  class UserNotificationUnread < SingletonApiResource
    attr_reader :user_notification

    def initialize(client, attributes, extra_headers = {})
      @user_notification = attributes.delete('user_notification')
      super(client, attributes, extra_headers)
    end

    def path
      user_notification.path + '/unread'
    end
  end
end
