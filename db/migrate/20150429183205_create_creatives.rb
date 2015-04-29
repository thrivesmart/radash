class CreateCreatives < ActiveRecord::Migration
  def change
    create_table :creatives do |t|
      t.references :org, index: true, foreign_key: true
      t.references :asset, index: true, foreign_key: true
      t.string :title, index: true
      t.string :url, index: true
      t.string :postername, index: true
      t.string :posterid, index: true
      t.string :promoted_thingid, index: true
      t.string :locale, index: true
      t.string :attachment_type
      t.text :attachment_html
      t.datetime :approved_at, index: true
      t.string :approver_name, index: true

      t.timestamps null: false
    end
    add_index :creatives, [:org_id, :locale]
  end
end
