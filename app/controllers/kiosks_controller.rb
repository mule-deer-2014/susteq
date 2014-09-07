class KiosksController < ApplicationController
  layout "provider_application"

  def index
    @kiosks = Provider.find(params[:provider_id]).kiosks
  end

  def show
    @kiosk = Kiosk.find(params[:id])
  end
end
