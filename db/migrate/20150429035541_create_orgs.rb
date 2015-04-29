class CreateOrgs < ActiveRecord::Migration
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :permalink, index: true
      t.string :email, index: true
      t.string :phone
      t.string :url
      t.references :owner, references: :users, index: true
      t.string :street_address1
      t.string :street_address2
      t.string :city
      t.string :state_province_region
      t.string :zip_postal_code
      t.string :country_code, index: true
      t.string :timezone
      t.string :currency_code

      t.timestamps null: false
    end
    add_foreign_key :orgs, :users, column: :owner_id
  end
end
