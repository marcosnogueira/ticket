class Coupon < ActiveRecord::Base
  belongs_to :event, :counter_cache => true
  belongs_to :user
  
  scope :available, :conditions => "user_id IS NULL"
end
