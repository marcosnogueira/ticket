class AddAmmountToHit < ActiveRecord::Migration
  def self.up
    add_column :hits, :ammount, :integer, :default => 0
  end

  def self.down
    add_column :hits, :ammount
  end
end
