class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :address
      t.string :country
      t.string :duns_number
      t.timestamps
    end
  end
end
