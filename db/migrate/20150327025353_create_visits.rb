class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :url_id
      t.string :ip
      t.text :referer

      t.timestamps null: false
    end
  end
end
