class CreateCodePlayBacks < ActiveRecord::Migration[5.0]
  def change
    create_table :code_play_backs do |t|
      t.integer :practice_id
      t.integer :user_id
      t.text :statement

      t.timestamps
    end
  end
end
