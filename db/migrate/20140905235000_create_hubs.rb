class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.integer :location_id
      t.string :type
      t.string :provider_id
      t.decimal :longitude, {precision: 10, scale: 6}
      t.decimal :latitude, {precision: 10, scale: 6}
      t.timestamps
    end
  end
end
