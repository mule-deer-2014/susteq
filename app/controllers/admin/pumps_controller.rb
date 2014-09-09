class Admin::PumpsController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def new
    @pump = Pump.new
    @providers = Provider.all
  end

  def show
    @pump = Pump.find params[:id]
  end

  def create
    if params[:provider_id]
      begin
      provider = Provider.find(params[:provider_id])
      @pump = Pump.create!(pump_params)
      redirect_to admin_provider_path(provider)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_provider_pump_path(provider)
      end
    else
      begin
      @pump = Pump.create!(pump_params)
      redirect_to admin_pumps_path
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_pump_path
      end
    end
  end

  def index
    @pumps = Pump.all
    respond_to do |format|
      format.html {render '/admin/pumps/index'}
      format.json {render json:Pump.get_all_with_transactions}
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

