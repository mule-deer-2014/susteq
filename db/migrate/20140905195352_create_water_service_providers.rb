class CreateWaterServiceProviders < ActiveRecord::Migration
  def change
    create_table :water_service_providers do |t|
      t.string :company_name
      t.string :address
      t.string :city
      t.string :country
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
