class AddColumnToSolutions < ActiveRecord::Migration[5.0]
  def change
    add_column :solutions, :code_type, :string
  end
end
