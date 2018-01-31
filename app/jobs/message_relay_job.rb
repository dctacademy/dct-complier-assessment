class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "messages_#{message.chat_room.id}",
      message: message.body,
      chat_room_id: message.chat_room_id,
      user: message.user.username
      head :ok
  end
end
