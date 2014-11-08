class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.references :task, index: true, :null => false
      t.references :user, index: true, :null => false
      t.text :src, :null => false
      t.integer :result
	  t.decimal :cpu_used
	  t.decimal :mem_used

      t.timestamps
    end
  end
end
