class Admin::KiosksController < ApplicationController
  include PerspectiveSummary
  layout "admin_application"
  before_filter :require_admin_signin

  def new
    @viz_data = 0
    @kiosk = Kiosk.new
    @providers = Provider.all
  end

  def index
    @kiosks = Kiosk.all
<<<<<<< HEAD
    hubs = getHubs
    @viz_data = [hubs].to_json
=======
    @viz_data = [credits_by_kiosk_for_all, getHubs].to_json
>>>>>>> origin/new-in-process-master
  end

  def show
    @kiosk = Kiosk.find params[:id]
    @viz_data = [credits_by_month(@kiosk)].to_json
  end

  def create
    @viz_data = 0
    if params[:provider_id]
      begin
      @provider = Provider.find(params[:provider_id])
      @kiosk = Kiosk.create!(kiosk_params)
      redirect_to admin_provider_path(@provider)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_provider_kiosk_path(@provider)
      end
    else
      begin
      @kiosk = Kiosk.create!(kiosk_params)
      redirect_to admin_kiosks_path
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to new_admin_kiosk_path
      end
    end
  end

  def edit
    @viz_data = 0
    @kiosk = Kiosk.find params[:id]
  end

  def update #MLM NOTES TO REFACTOR - Need different way to redirect user when approach from nested provider route vs top level route
    kiosk = Kiosk.find(params[:id])
    if params[:provider_id]
      begin
      provider = Provider.find(params[:provider_id])
      kiosk.update!(kiosk_params)
      redirect_to admin_provider_path(provider)
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to edit_admin_provider_kiosk_path(provider,kiosk)
      end
    else
      begin
      kiosk.update!(kiosk_params)
      redirect_to admin_kiosks_path
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:error_messages] = invalid.record.errors.full_messages
        redirect_to edit_admin_kiosk_path(kiosk)
      end
    end
  end

  def destroy
    Kiosk.destroy(params[:id])
    if params[:provider_id]
      provider = Provider.find(params[:provider_id])
      redirect_to admin_provider_path(provider)
    else
      redirect_to admin_kiosks_path
    end
  end

  private
  def kiosk_params
    params.require(:kiosk).permit(:name,:longitude, :latitude, :location_id, :provider_id,:status_code)
  end
end
