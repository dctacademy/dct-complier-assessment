class AddPointsToAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :points, :integer
  end
end
