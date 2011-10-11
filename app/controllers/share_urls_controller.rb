class ShareUrlsController < ApplicationController

  def share
    @share_url = ShareUrl.find_by_id_base62(params[:id_base62])
    @share_url.increment(:share_count)
    @share_url.decrement(:view_count)
    @share_url.save
    
    render :nothing => true
  end
  
  def not_share
    @share_url = ShareUrl.find_by_id_base62(params[:id_base62])
    @share_url.increment(:not_share_count)
    @share_url.decrement(:view_count)
    @share_url.save
    
    render :nothing => true
  end
  
  def hit
    @share_url = ShareUrl.find_by_id_base62(params[:id_base62])
    @share_url.increment(:hit_count)
    @share_url.save
    
    session[:referer] = request.env['HTTP_REFERER'] if request.env['HTTP_REFERER']
    session[:share_url_id_base62] = @share_url.id_base62
    
    @referral_config.each_pair do |key, value|
      if key == @share_url.resource_class_name
        param = @share_url.resource_id
        redirect_to eval(value['redirect_url'])
      end
    end
  end
  
  def image_proxy
    @share_url = ShareUrl.find params[:url].split('l/')[1]
    @share_url.increment(:view_count).save
    
    redirect_to params[:image]
  end
  
end
