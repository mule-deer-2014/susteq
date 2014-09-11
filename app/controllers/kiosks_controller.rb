class KiosksController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @kiosks = current_provider.kiosks
    @total_credits_sold = @kiosks.reduce(0) { |sum, kiosk| sum + kiosk.credits_sold }
    @viz_data = credits_by_kiosk(current_provider)

    respond_to do |format|
      format.html
      format.json{ render json: Kiosk.get_many_with_transaction(@kiosks) }
    end
  end

  def show
    @kiosk = Kiosk.find(params[:id])
    @viz_data = [sold_by_month(@kiosk)].to_json
  end
end
