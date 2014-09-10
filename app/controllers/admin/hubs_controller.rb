class Admin::HubsController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def index
    @kiosks = Kiosk.all
    @pumps = Pump.all
  end

  def new
    @new_location_id = params[:new_hubs_id]
    @providers = Provider.all
    @hub = Hub.new(location_id: @new_location_id)
  end

  def create
    if params[:provider_id]
      begin
      @provider = Provider.find(params[:provider_id])
      @kiosk = Hub.create!(hub_params)
      redirect_to admin_provider_path(@provider)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_provider_hub_path(@provider)
      end
    else
      begin
      @hub = Hub.create!(hub_params)
      redirect_to admin_dashboard_path
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_hub_path
      end
    end
  end

  private
  def hub_params
    params.require(:hub).permit(:type,:name,:longitude, :latitude, :location_id, :provider_id,:status_code)
  end
end
