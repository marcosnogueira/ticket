class CreateSourceUrls < ActiveRecord::Migration
  def self.up
    create_table :source_urls do |t|
      t.integer :source_id
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :source_urls
  end
end
