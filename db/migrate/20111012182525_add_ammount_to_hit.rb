class AddAmmountToHit < ActiveRecord::Migration
  def self.up
    add_column :hits, :ammount, :integer, :default => 0
  end

  def self.down
    remove_column :hits, :ammount
  end
end
