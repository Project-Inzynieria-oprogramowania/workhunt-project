class NotificationsController < ApplicationController
    before_action :check_authenticate
  
    def index
        @notifications = current_user.notifications.order(created_at: :desc)
    end
  
    def mark_as_read
        @notification = current_user.notifications.find(params[:id])
        @notification.update(read: true)
        redirect_back fallback_location: root_path
    end
end