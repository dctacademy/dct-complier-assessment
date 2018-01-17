class AddColumnTimeInSecondsToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :time_in_seconds, :integer, default: 0
  end
end
