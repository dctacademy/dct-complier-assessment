class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.text :statement
      t.string :output
      t.integer :user_id
      t.string :language
      t.integer :assignment_id
      t.integer :practice_id

      t.timestamps
    end
  end
end
