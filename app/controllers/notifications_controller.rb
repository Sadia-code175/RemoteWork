
class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.mark_as_read
    redirect_to notifications_path, notice: 'Notification marked as read'
  end
end