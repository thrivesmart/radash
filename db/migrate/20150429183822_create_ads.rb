class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :org, index: true, foreign_key: true
      t.references :creative, index: true, foreign_key: true
      t.string :bid_type, index: true
      t.integer :bid_in_cents
      t.text :locations
      t.text :devices
      t.text :os
      t.text :os_versions
      t.text :subreddits
      t.text :interests
      t.text :placements
      t.datetime :paused_at, index: true
      t.datetime :approved_at, index: true
      t.string :approver_name, index: true

      t.timestamps null: false
    end
    add_index :ads, [:org_id, :creative_id]
    add_index :ads, [:org_id, :bid_type]
    
    create_table :ads_campaigns, id: false do |t|
      t.references :ad, index: true, foreign_key: true
      t.references :campaign, index: true, foreign_key: true
    end
  end
end
