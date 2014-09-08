class Admin::HubsController < ApplicationController
  before_filter :require_admin_signin

  def index
    @kiosks = Kiosk.all
    @pumps = Pump.all
  end



end
