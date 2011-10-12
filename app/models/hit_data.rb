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
  
  def top_ammount_sources
    hits = self.hits.includes(:source).group_by(&:source_id).sort {|a, b| Source.find(b.first).hits.sum(:ammount) <=> Source.find(a.first).hits.sum(:ammount)}
    hits.each do |hit|
      hit[1] = Source.find(hit.first).hits.sum(:ammount, :conditions => { :hit_data_id => self.id })
    end
  end
  
  def top_ammount_users
    hits = self.hits.includes(:user).group_by(&:user_id).sort {|a, b| User.find(b.first).hits.sum(:ammount) <=> User.find(a.first).hits.sum(:ammount)}
    hits.each do |hit|
      hit[1] = User.find(hit.first).hits.sum(:ammount, :conditions => { :hit_data_id => self.id })
    end
  end
  
  def rates
    total_share = ShareUrl.sum(:share_count).to_f
    total_hit = ShareUrl.sum(:hit_count).to_f
    
    share = total_share > 0 ? (self.hits.count / total_share) : 0.0
    hit = total_hit > 0 ? (self.hits.count / total_hit) : 0.0
    
    [share.round(2), hit.round(2)]    
  end
end
