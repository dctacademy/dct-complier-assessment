class ChatRoom < ApplicationRecord
	has_many :messages, dependent: :destroy
	belongs_to :batch

	validates_presence_of :title, :batch_id
end
