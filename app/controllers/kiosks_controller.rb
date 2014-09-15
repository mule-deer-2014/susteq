class KiosksController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @kiosks = current_provider.kiosks
    js :viz_data => [credits_by_kiosk_for_provider(current_provider), getHubs]
    @total_credits_sold = @kiosks.reduce(0) { |sum, kiosk| sum + kiosk.credits_sold }
  end

  def show
    @kiosk = Kiosk.find(params[:id])
    js :viz_data => [credits_by_month(@kiosk)]
  end
end
