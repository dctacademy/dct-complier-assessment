json.extract! chat_room, :id, :title, :batch_id, :created_at, :updated_at
json.url chat_room_url(chat_room, format: :json)
