class Referral < ApplicationController
  def self.track hit_data_name
    unless false#current_user.blank?
      @hit_data = HitData.find_or_create_by_name :name => hit_data_name
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      puts session.inspect
      @share_url = ShareUrl.find_by_id_base62 session[:share_url_id_base62]
      @source = Source.find_or_create_by_domain :domain => URI.parse(session[:referer]).host if session[:referer]
      @source_url = SourceUrl.find_or_create_by_url :url => session[:referer], :source_id => @source.id if session[:referer]
      
      @hit = Hit.create :hit_data_id => @hit_data.id, :user_id => @share_url.user_id, :resource_id => @share_url.resource_id, :resource_class_name => @share_url.resource_class_name, :source_url_id => @source_url.id if @share_url
    end
  end  
end
