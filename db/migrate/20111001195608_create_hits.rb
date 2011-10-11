class CreateHits < ActiveRecord::Migration
  def self.up
    create_table :hits do |t|
      t.integer :hit_data_id
      t.integer :user_id
      t.integer :resource_id
      t.string :resource_class_name
      t.integer :source_url_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hits
  end
end
