class AddNotShareCountToShareUrl < ActiveRecord::Migration
  def self.up
    add_column :share_urls, :not_share_count, :integer, :default => 0
  end

  def self.down
    remove_column :share_urls, :not_share_count
  end
end
