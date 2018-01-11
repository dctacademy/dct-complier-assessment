class AddPointsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :points, :integer, default: 0
  end
end
