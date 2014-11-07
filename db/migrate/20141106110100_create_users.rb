class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :password_hash, :null => false
	  t.string :password_salt, :null => false
	  
	  t.boolean :is_admin?, :null => false, :default => false
	  t.boolean :is_tester?, :null => false, :default => false

      t.timestamps
    end

	add_index :users, :name, :unique => true
    
  end
end
