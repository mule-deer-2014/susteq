class Admin::PumpsController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def index
    @pumps = Pump.all
  end

  def new
    @pump = Pump.new
    @providers = Provider.all
  end

  def show
    @pump = Pump.find params[:id]
  end

  def create
    @pump = Pump.new(pump_params)
    if params[:provider_id]
      provider = Provider.find(params[:provider_id])
      redirect_to admin_provider_path(provider) and return if @pump.save
      redirect_to new_admin_provider_pump_path(provider)
    else
      redirect_to admin_pumps_path and return if @pump.save
      redirect_to new_admin_pump_path
    end
  end

  def edit
    @pump = Pump.find params[:id]
  end

  def update #MLM NOTES TO REFACTOR - Need different way to redirect user when approach from nested provider route vs top level route
    pump = Pump.find(params[:id])
    if params[:provider_id]
      provider = Provider.find(params[:provider_id])
      if pump.update(pump_params)
        redirect_to admin_provider_path(provider)
      else
        redirect_to edit_admin_provider_pump_path(provider,pump)
      end
    else
      if pump.update(pump_params)
        redirect_to admin_pumps_path
      else
        redirect_to edit_admin_pump_path(pump)
      end
    end
  end

  def destroy
    Pump.destroy(params[:id])
    if params[:provider_id]
      @provider = Provider.find(params[:provider_id])
      redirect_to admin_provider_path(@provider)
    else
      redirect_to admin_pumps_path
    end
  end



  private

  def pump_params
    params.require(:pump).permit(:name,:longitude, :latitude, :location_id, :provider_id)
  end

end

