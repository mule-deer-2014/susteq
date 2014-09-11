class PumpsController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = current_provider.pumps
    @total_dispensed = @pumps.reduce(0) { |sum, pump| sum + pump.water_dispensed }
    @viz_data = [dispensed_by_pump_for_provider(current_provider)].to_json

    respond_to do |format|
      format.html
      format.json{ render json: Pump.get_many_with_transaction(@pumps)}
    end
  end

  def show
    @pump = Pump.find(params[:id])
    @viz_data = [dispensed_by_month(@pump)].to_json
  end
end
