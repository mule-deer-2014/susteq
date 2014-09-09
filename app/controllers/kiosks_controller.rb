class KiosksController < ApplicationController
  layout "provider_application"

  def index
    @total_credits_sold = (@kiosks = current_provider.kiosks).reduce(:+)
    respond_to do |format|
      format.html
      format.json{ render json: Kiosk.get_many_with_transaction(@kiosks)}
    end
  end

  def show
    @kiosk = Kiosk.find(params[:id])
  end
end
