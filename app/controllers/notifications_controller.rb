class NotificationsController < ApplicationController
    before_action :check_authenticate
    
    def marks_as_read
        ids = JSON.parse(params[:notification_ids])
        ids.each do | id |
            notification = Notification.find_by(id: id)
            if notification.read == false
                notification.update(read: true)
            end
        end
    end
end