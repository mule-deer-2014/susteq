class KiosksController < ApplicationController
  layout "provider_application"

  def index
    @kiosks = current_provider.kiosks
    @total_credits_sold = @kiosks.reduce(0) { |sum, kiosk| sum + kiosk.credits_sold }

    respond_to do |format|
      format.html
      format.json{ render json: Kiosk.get_many_with_transaction(@kiosks) }
    end
  end

  def show
    @kiosk = Kiosk.find(params[:id])
  end
end
