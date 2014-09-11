class KiosksController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @kiosks = current_provider.kiosks
    @viz_data = [credits_by_kiosk_for_provider(current_provider), getHubs].to_json
    @total_credits_sold = @kiosks.reduce(0) { |sum, kiosk| sum + kiosk.credits_sold }
  end

  def show
    @kiosk = Kiosk.find(params[:id])
    @viz_data = [sold_by_month(@kiosk)].to_json
  end
end
