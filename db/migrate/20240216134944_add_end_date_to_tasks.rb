class AddEndDateToTasks < ActiveRecord::Migration[6.1]
  def change
      add_column :tasks, :end_date, :datetime,default: -> { 'NOW()' } ,null: false
  end
end
