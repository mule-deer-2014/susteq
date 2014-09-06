class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name, null:false
      t.string :address, null:false
      t.string :country, null:false
      t.string :duns_number, null:false
      t.timestamps
    end
  end
end
