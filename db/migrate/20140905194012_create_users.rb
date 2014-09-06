class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type
      t.integer :provider_id
      t.string :name, null:false
      t.string :email, null:false
      t.string :password_hash, null:false
      t.string :remember_token
      t.index :remember_token
      t.string :phone_number
      t.timestamps
    end
  end
end
