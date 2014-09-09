class Admin::HubsController < ApplicationController
  before_filter :require_admin_signin

  def index
    @kiosks = Kiosk.all
    @pumps = Pump.all
  end

  def add_new_hubs
    @new_location_ids = params[:new_hubs_ids]
  end
end
