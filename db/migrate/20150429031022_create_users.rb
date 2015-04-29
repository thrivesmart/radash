class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, index: true
      t.string :email, index: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone
      t.string :picurl
      t.string :redditid, index: true
      t.boolean :superuser, index: true

      t.timestamps null: false
    end
  end
end
