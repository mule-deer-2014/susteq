class Admin::HubsController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def index
    @viz_data = 0
    @kiosks = Kiosk.all
    @pumps = Pump.all
  end

  def new
    @viz_data = 0
    @new_location_id = params[:new_hubs_id]
    @providers = Provider.all
    @hub = Hub.new(location_id: @new_location_id)
  end

  def create
    begin
    @hub = Hub.create!(hub_params)
    redirect_to admin_dashboard_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_admin_hub_path
    end
  end

  private
  def hub_params
    params.require(:hub).permit(:type,:name,:longitude, :latitude, :location_id, :provider_id,:status_code)
  end
end
