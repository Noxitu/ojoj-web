class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, :null => false
      t.timestamps
    end
    
    create_table :contests do |t|
      t.string :name, :null => false
      t.references :group, index: true, :null => false
      t.timestamp
    end
    
    create_table :groups_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :group
    end
    
    add_reference :tasks, :contest, index: true
  end
end
