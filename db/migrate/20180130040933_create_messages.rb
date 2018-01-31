class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :chat_room_id
      t.integer :batch_id
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
