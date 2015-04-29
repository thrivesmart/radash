class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :org, index: true, foreign_key: true
      t.attachment :file
      t.string :name, index: true
      t.text :html
      t.integer :width, index: true
      t.integer :height, index: true

      t.timestamps null: false
    end
    add_index :assets, [:org_id, :width, :height]
  end
end
