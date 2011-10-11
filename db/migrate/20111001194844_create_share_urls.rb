class CreateShareUrls < ActiveRecord::Migration
  def self.up
    create_table :share_urls do |t|
      t.integer :user_id
      t.integer :resource_id
      t.string :resource_class_name
      t.string :id_base62
      t.integer :share_count, :default => 0
      t.integer :hit_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :share_urls
  end
end
