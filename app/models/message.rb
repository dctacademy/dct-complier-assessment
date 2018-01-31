class Message < ApplicationRecord
	belongs_to :chat_room
	belongs_to :batch
	belongs_to :user

	validates_presence_of :chat_room_id, :batch_id, :user_id, :body
end
