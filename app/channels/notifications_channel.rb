class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications:#{current_user.id}"
    # logger.info("Subscribed to notifications channel for user #{current_user.id}")
  end

  def unsubscribed
    # logger.info("Unubscribed to notifications channel")
    # Any cleanup needed when channel is unsubscribed
    # stop_all_streams
  end

  def receive(data)
    # logger.info("Received data: #{data.inspect}")
    # ActionCable.server.broadcast("notifications:#{current_user}", data)
  end
end
