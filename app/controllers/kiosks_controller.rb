class KiosksController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @kiosks = current_provider.kiosks
<<<<<<< HEAD
    sum = 0
    @kiosks.each do |k|
      sum += k.credits_sold
    end
    @total_credits_sold = sum
    hubs = getHubs
    @viz_data = [hubs].to_json
=======
    @viz_data = [credits_by_kiosk_for_provider(current_provider), getHubs].to_json
>>>>>>> origin/new-in-process-master
    @total_credits_sold = @kiosks.reduce(0) { |sum, kiosk| sum + kiosk.credits_sold }
  end

  def show
    @kiosk = Kiosk.find(params[:id])
    @viz_data = [credits_by_month(@kiosk)].to_json
  end
end
