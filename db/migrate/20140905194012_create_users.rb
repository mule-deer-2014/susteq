class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type
      t.integer :provider_id
      t.string :name
      t.string :email
      t.string :password_hash
      t.index :remember_token
      t.string :phone_number
      t.timestamps
    end
  end
end
