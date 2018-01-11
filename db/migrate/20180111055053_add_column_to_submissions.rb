class AddColumnToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :is_checked, :boolean, default: false
  end
end
