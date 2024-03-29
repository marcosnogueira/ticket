class AddNameAndCreditToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :credit, :float, :default => 0
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :credit
  end
end
