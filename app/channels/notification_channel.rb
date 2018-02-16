class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    logger.debug(data)
    ActionCable.server.broadcast "notification_channel", {
      name: data['name'],
      starttime: data['starttime'],
      endtime: data['endtime']
    }
  end
end
