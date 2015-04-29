class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :org, index: true, foreign_key: true
      t.attachment :file
      t.text :html
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
