class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name, :null => false
      t.timestamps
    end
	
	create_table :permissions_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :permission
    end
	
	remove_column :users, :is_admin?, :boolean
	remove_column :users, :is_tester?, :boolean
	
	root_permission = Permission.create :name => 'Manage permissions'
	Permission.create :name => 'Manage tasks'
	Permission.create :name => 'Tester API'
	Permission.create :name => 'Manage subs'
	Permission.create :name => 'Manage shares'	
	
	User.find(1).permissions << root_permission
  end
end
