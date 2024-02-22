class AddDeadlineToTasks < ActiveRecord::Migration[6.1]
  def change
      add_column :tasks,:deadline,:date,null: false,default: '2024-02-24'
  end
end
