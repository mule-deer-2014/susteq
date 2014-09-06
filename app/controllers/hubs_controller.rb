module Admin
  class HubsController < ApplicationController

    def index
      @kiosks = Kiosk.all
      @pumps = Pump.all
    end


  end
end

