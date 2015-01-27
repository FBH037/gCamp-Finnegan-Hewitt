class CreateTasks < ActiveRecord::Base
  def change
    create_table :tasks do |t|
      t.string :description
      t.timestamps null: false
      t.date :due_date
    end
  end
end
