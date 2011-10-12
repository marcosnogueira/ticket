class Admin::ReferralController < Admin::ApplicationController
  layout 'referral'
  
  def dashboard
    @hits_data = HitData.includes(:hits)
    
    @timeline = Hit.where('created_at > :one_month_ago', :one_month_ago => (Date.today - 1.month)).order('created_at ASC').all.group_by(&:created_at).to_a
    
    @top_users = []
    @top_sources = []
    @top_source_urls = []
    @top_ammount_sources = []
    @top_ammount_users = []
    @rates = []
    
    @visit_count = @click_rate = @share_rate = @viral_index = @viral_lift = 0
    
    @hits_data.each do |hit_data|
      id = hit_data.id
      @top_users[id] = hit_data.top_users
      @top_sources[id] = hit_data.top_sources      
      @top_source_urls[id] = hit_data.top_source_urls
      @top_ammount_sources[id] = hit_data.top_ammount_sources
      @top_ammount_users[id] = hit_data.top_ammount_users
      
      @rates[id] = hit_data.rates
    end
    
    @visit_count = ReferralStats.first.visit_count
    @click_rate = ShareUrl.sum(:hit_count).to_f / ShareUrl.sum(:share_count).to_f if ShareUrl.sum(:hit_count).to_f > 0 && ShareUrl.sum(:share_count).to_f > 0
    @share_rate = (ShareUrl.count(:conditions => 'share_count > 0 or hit_count > 0').to_f / @visit_count.to_f)
    @viral_index = @click_rate * @share_rate    
    @viral_lift = @share_rate * @click_rate * (HitData.find_by_name("cadastro").hits.count.to_f / ShareUrl.count(:conditions => 'share_count > 0 or hit_count > 0').to_f) if HitData.find_by_name("cadastro")
    
    #tratamento para views
    #@click_rate = @click_rate * 100
    @share_rate = @share_rate * 100
    
  end
  
  def visit
    @referral_stats = ReferralStats.first
    @referral_stats.increment(:visit_count).save
    
    render :nothing => true
  end
  
end
