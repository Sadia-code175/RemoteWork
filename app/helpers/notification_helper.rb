module NotificationHelper
    def unread_notifications
      current_user.notifications.unread if user_signed_in?
    end
  end