class AddColumnOwnerPhoneAndSimToHubs < ActiveRecord::Migration
  def change
    add_column :hubs, :owner_phone_number, :string
    add_column :hubs, :owner_sim_number, :string
  end
end
