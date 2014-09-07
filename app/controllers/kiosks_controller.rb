class KiosksController < ApplicationController
  layout "provider_application"

  def index
    @kiosks = Provider.find(params[:provider_id]).kiosks
    sum = 0
    @kiosks.each do |k|
      sum += k.credits_sold
    end
    @total_credits_sold = sum
  end

  def show
    @kiosk = Kiosk.find(params[:id])
  end
end
