class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :link
      t.integer :visits_count, default: 0
      t.timestamps null: false
    end
    add_index :urls, :link
  end
  
end
