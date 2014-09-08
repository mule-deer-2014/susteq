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
    respond_to do |format|
      format.html{ render '/employees/pumps/index'}
      format.json{ render json: Pump.get_many_with_transaction(@pumps)}
    end
  end

  def show
    @pump = Pump.find(params[:id])
  end
end
