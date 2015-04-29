class CreateCreatives < ActiveRecord::Migration
  def change
    create_table :creatives do |t|
      t.references :org, index: true, foreign_key: true
      t.references :asset, index: true, foreign_key: true
      t.string :title
      t.string :url
      t.string :postername
      t.string :posterid
      t.string :promoted_thingid
      t.string :locale
      t.string :attachment_type
      t.text :attachment_html
      t.datetime :approved_at
      t.string :approver_name

      t.timestamps null: false
    end
  end
end
