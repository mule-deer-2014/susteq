class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.string :name
      t.integer :location_id, null:false
      t.string :type, null:false
      t.string :provider_id
      t.decimal :longitude, {precision: 10, scale: 6}
      t.decimal :latitude, {precision: 10, scale: 6}
      t.timestamps
    end
  end
end
