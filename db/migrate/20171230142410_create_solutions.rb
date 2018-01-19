class CreateSolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :solutions do |t|
      t.integer :user_id
      t.text :body
      t.string :language
      t.integer :assignment_id

      t.timestamps
    end
  end
end
