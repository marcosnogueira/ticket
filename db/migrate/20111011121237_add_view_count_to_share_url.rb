class AddViewCountToShareUrl < ActiveRecord::Migration
  def self.up
    add_column :share_urls, :view_count, :integer, :default => 0
  end

  def self.down
    remove_column :share_urls, :view_count
  end
end
