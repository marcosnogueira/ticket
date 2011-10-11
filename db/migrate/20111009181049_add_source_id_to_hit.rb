class AddSourceIdToHit < ActiveRecord::Migration
  def self.up
    add_column :hits, :source_id, :integer
  end

  def self.down
    remove_column :hits, :source_id
  end
end
