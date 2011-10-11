class Source < ActiveRecord::Base
  has_many :source_urls
  has_many :hits
end
