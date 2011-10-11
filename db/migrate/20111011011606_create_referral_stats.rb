class CreateReferralStats < ActiveRecord::Migration
  def self.up
    create_table :referral_stats do |t|
      t.integer :visit_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :referral_stats
  end
end
