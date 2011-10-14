class CreateHitData < ActiveRecord::Migration
  def self.up
    create_table :hit_datas do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hit_datas
  end
end
