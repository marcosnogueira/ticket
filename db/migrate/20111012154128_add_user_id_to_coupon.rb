class AddUserIdToCoupon < ActiveRecord::Migration
  def self.up
    add_column :coupons, :user_id, :integer
  end

  def self.down
    remove_column :coupons, :user_id
  end
end
