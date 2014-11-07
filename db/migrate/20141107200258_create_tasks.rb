class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, :null => false
      t.text :content, :null => false

      t.timestamps
    end
  end
end
