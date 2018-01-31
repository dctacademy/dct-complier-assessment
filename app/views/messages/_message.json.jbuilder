json.extract! message, :id, :chat_room_id, :batch_id, :body, :user_id, :created_at, :updated_at
json.url message_url(message, format: :json)
