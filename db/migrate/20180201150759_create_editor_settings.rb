class CreateEditorSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :editor_settings do |t|
      t.integer :user_id
      t.string :theme_name
      t.string :theme_css

      t.timestamps
    end
  end
end
