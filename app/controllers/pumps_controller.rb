class PumpsController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = current_provider.pumps
    sum = 0
    @pumps.each do |p|
      sum += p.water_dispensed
    end
    @total_dispensed = sum
    hubs = getHubs
    @viz_data = [hubs].to_json
    @total_dispensed = @pumps.reduce(0) { |sum, pump| sum + pump.water_dispensed }
  end

  def show
    @pump = Pump.find(params[:id])
  end
end
