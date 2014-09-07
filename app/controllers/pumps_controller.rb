class PumpsController < ApplicationController
  layout "provider_application"

  def index
    @pumps = Provider.find(params[:provider_id]).pumps
  end

  def show
    @pump = Pump.find(params[:id])
  end
end
