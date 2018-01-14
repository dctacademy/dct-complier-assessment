class ChangeColumnTypeOfIsChecked < ActiveRecord::Migration[5.0]
  def change
  	change_column :submissions, :is_checked, :string
  end
end
