class Admin::HubsController < ApplicationController

  def index
    @kiosks = Kiosk.all
    @pumps = Pump.all
  end


end


