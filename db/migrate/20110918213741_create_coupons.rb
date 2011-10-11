class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.float :price
      t.string :title
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
