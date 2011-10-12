require 'uri'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #Filters
  before_filter :load_referral_config
  
  def home
    #@events = Event.where()
  end
  
  def cadastro
    track 'cadastro'
     
    render :text => session[:share_url_id_base62]
  end
  
  def track hit_data_name
    unless false#current_user.blank?
      @hit_data = HitData.find_or_create_by_name :name => hit_data_name
      @share_url = ShareUrl.find_by_id_base62 session[:share_url_id_base62]
      @source = Source.find_or_create_by_domain :domain => URI.parse(session[:referer]).host if session[:referer]
      @source_url = SourceUrl.find_or_create_by_url :url => session[:referer], :source_id => @source.id if session[:referer]
      
      @hit = Hit.create :hit_data_id => @hit_data.id, :user_id => @share_url.user_id, :resource_id => @share_url.resource_id, :resource_class_name => @share_url.resource_class_name, :source_url_id => @source_url.id, :source_id => @source.id if @share_url
      
      session.delete :referer
      session.delete :share_url_id_base62
    end
  end
  
  def load_referral_config
    @referral_config = YAML::load(File.open("#{RAILS_ROOT}/config/referral.yml"))
  end
end
