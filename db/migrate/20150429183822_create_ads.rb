class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :org, index: true, foreign_key: true
      t.references :creative, index: true, foreign_key: true
      t.string :bid_type
      t.integer :bid_in_cents
      t.text :locations
      t.text :devices
      t.text :os
      t.text :os_versions
      t.text :subreddits
      t.text :interests
      t.text :placements
      t.datetime :paused_at
      t.datetime :approved_at
      t.string :approver_name

      t.timestamps null: false
    end
    
    create_table :ads_campaigns, id: false do |t|
      t.references :ad, index: true, foreign_key: true
      t.references :campaign, index: true, foreign_key: true
    end
  end
end
