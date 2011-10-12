class AddCouponCountToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :coupons_count, :integer, :default => 0
    
    Event.all.each do |event|
      Event.update_counters(event.id, :coupons_count => event.coupons.length)
    end

  end

  def self.down
    remove_column :events, :coupons_count
  end
end
