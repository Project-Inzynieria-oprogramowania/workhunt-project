class NotificationsController < ApplicationController
    before_action :check_authenticate
    
    def marks_as_read
        current_user.notifications.each do | notification |
            notification.update(read: true)
        end
    end
end