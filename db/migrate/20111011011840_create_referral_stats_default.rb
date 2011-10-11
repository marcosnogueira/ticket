class CreateReferralStatsDefault < ActiveRecord::Migration
  def self.up
    ReferralStats.create
  end

  def self.down
    ReferralStats.first.destroy
  end
end
