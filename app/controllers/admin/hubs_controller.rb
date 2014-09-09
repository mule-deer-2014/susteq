class Admin::HubsController < ApplicationController
  before_filter :require_admin_signin

  def index
    @kiosks = Kiosk.all
    @pumps = Pump.all
  end

  def add_new_hub
    @new_location_id = params[:new_hubs_id]
    @providers = Provider.all
    @kiosk = Kiosk.new(location_id: @new_location_id)
    @pump = Pump.new(location_id: @new_location_id)
  end
end
