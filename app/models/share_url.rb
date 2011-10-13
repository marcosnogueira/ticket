class ShareUrl < ActiveRecord::Base
  #Filters
  after_create :convert_id_to_base62
  
  #Associations
  belongs_to :user
  
  def url
    "#{Rails.application.routes.url_helpers.root_url(:host => 'goalyzer.com')}l/#{self.id_base62}"
  end
  
  private
    def convert_id_to_base62
      update_attribute(:id_base62, self.id.base62_encode)
    end
end
