class PumpsController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = current_provider.pumps
    js :viz_data => [dispensed_by_pump_for_provider(current_provider), getHubs]
    @total_dispensed = @pumps.reduce(0) { |sum, pump| sum + pump.water_dispensed }
  end

  def show
    @pump = Pump.find(params[:id])
    js :viz_data => [dispensed_by_month(@pump)]
  end
end
