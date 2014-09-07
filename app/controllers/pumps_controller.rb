class PumpsController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def index
    @pumps = Provider.find(params[:provider_id]).pumps
  end

  def show
    @pump = Pump.find(params[:id])
  end
end
