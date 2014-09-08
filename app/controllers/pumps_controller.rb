class PumpsController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = current_provider.pumps
    sum = 0
    @pumps.each do |p|
      sum += p.water_dispensed
    end
    @total_dispensed = sum
  end

  def show
    @pump = Pump.find(params[:id])
  end
end
