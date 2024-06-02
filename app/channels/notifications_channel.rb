class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.id}"
    logger.info("Subscribed to notifications channel for user #{current_user.id}")
  end

  def unsubscribed
    logger.info("Unubscribed to notifications channel")
    # Any cleanup needed when channel is unsubscribed
  end
end
