class MessagesChannel < ApplicationCable::Channel  
	
	def subscribed
		chat_rooms = (current_user.role? "admin") ? ChatRoom.all : ChatRoom.where(batch_id: current_user.student.batches.pluck(:id))
    chat_rooms.each do |chat_room|
      stream_from "messages_#{chat_room.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

end  