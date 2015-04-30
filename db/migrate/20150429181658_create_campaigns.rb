class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.references :org, index: true, foreign_key: true
      t.string :name
      t.integer :total_budget_in_cents
      t.integer :goal_value
      t.string :goal_type
      t.text :flights
      t.datetime :paused_at, index: true

      t.timestamps null: false
    end
    add_index :campaigns, [:org_id, :paused_at]
  end
end
