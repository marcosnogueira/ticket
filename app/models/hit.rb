class Hit < ActiveRecord::Base
  belongs_to :hit_data
  belongs_to :user
  belongs_to :source_url
  belongs_to :source  
  
  scope :two_weeks_ago, :conditions => ['created_at > :two_weeks', :two_weeks => (Date.today - 14.days)]
end
