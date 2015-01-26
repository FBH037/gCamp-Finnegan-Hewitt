class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.timestamps null: false
      t.date_of_birth :date_of_birth
    end
  end
end
