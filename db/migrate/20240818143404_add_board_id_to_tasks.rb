class AddBoardIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :board_id, :integer
  end
end
