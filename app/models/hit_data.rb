class HitData < ActiveRecord::Base
  has_many :hits
  
  def top_users
    self.hits.includes(:user).group_by(&:user_id).sort {|a, b| b.last.size <=> a.last.size}
  end
  
  def top_sources
    self.hits.includes(:source).group_by(&:source_id).sort {|a, b| b.last.size <=> a.last.size}
  end
  
  def top_source_urls
    self.hits.includes(:source_url).group_by(&:source_url_id).sort {|a, b| b.last.size <=> a.last.size}
  end
  
  def rates
    total_share = ShareUrl.sum(:share_count).to_f
    total_hit = ShareUrl.sum(:hit_count).to_f
    
    [(self.hits.count / total_share).round(2), (self.hits.count / total_hit).round(2)]    
  end
end
