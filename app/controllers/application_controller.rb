require 'uri'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #Filters
  before_filter :load_referral_config
  
  def home
    @events = Event.includes(:coupons).all.select do |e|
      e.coupons.available.count > 0
    end
  end
  
  def track hit_data_name, ammount = 0
    @hit_data = HitData.find_or_create_by_name :name => hit_data_name
    @share_url = ShareUrl.find_by_id_base62 session[:share_url_id_base62]
    @source = Source.find_or_create_by_domain :domain => URI.parse(session[:referer]).host if session[:referer]
    @source_url = SourceUrl.find_or_create_by_url :url => session[:referer], :source_id => @source.id if session[:referer]
    
    unless current_user && @share_url && @share_url.user_id == current_user.id
      @hit = Hit.create :hit_data_id => @hit_data.id, :user_id => @share_url.user_id, :resource_id => @share_url.resource_id, :resource_class_name => @share_url.resource_class_name, :source_url_id => @source_url.id, :source_id => @source.id, :ammount => ammount if @share_url
    end
    session.delete :referer
    session.delete :share_url_id_base62
  end
  
  def load_referral_config
    @referral_config = YAML::load(File.open("#{RAILS_ROOT}/config/referral.yml"))
  end
end
