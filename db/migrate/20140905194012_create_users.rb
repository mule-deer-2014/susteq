class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type
      t.integer :water_service_provider_id
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :phone_number

      t.timestamps
    end
  end
end
