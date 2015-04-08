class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description
      t.belongs_to :task, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
