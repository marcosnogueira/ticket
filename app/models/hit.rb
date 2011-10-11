class Hit < ActiveRecord::Base
  belongs_to :hit_data
  belongs_to :user
  belongs_to :source_url
  belongs_to :source  
end
