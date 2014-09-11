class PumpsController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = current_provider.pumps
    @total_dispensed = @pumps.reduce(0) { |sum, pump| sum + pump.water_dispensed }

    respond_to do |format|
      format.html
      format.json{ render json: Pump.get_many_with_transaction(@pumps)}
    end
  end

  def show
    @pump = Pump.find(params[:id])
  end
end
