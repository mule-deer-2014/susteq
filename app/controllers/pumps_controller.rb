class PumpsController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = current_provider.pumps
<<<<<<< HEAD
    sum = 0
    @pumps.each do |p|
      sum += p.water_dispensed
    end
    @total_dispensed = sum
    hubs = getHubs
    @viz_data = [hubs].to_json
=======
    @viz_data = [dispensed_by_pump_for_provider(current_provider), getHubs].to_json
>>>>>>> origin/new-in-process-master
    @total_dispensed = @pumps.reduce(0) { |sum, pump| sum + pump.water_dispensed }
  end

  def show
    @pump = Pump.find(params[:id])
    @viz_data = [dispensed_by_month(@pump)].to_json
  end
end
