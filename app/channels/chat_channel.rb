class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(
      content: data['message'],
      sender_id: data['sender_id'],
      sender_type: data['sender_type'],
      receiver_id: data['receiver_id']
    )
    ActionCable.server.broadcast("chat_#{params[:room]}", message: data['message'])
  end
end
