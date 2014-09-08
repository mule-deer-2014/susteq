class Admin::KiosksController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def new
    @kiosk = Kiosk.new
    @providers = Provider.all
  end

  def index
    @kiosks = Kiosk.all
    respond_to do |format|
      format.html {render 'admin/kiosks/index'}
      format.json {render json:Kiosk.get_all_with_transactions}
    end
  end

  def show
    @kiosk = Kiosk.find params[:id]
  end

  def create
    @kiosk = Kiosk.new(kiosk_params)
    if params[:provider_id]
      provider = Provider.find(params[:provider_id])
      redirect_to admin_provider_path(provider) and return if @kiosk.save
      redirect_to new_admin_provider_kiosk_path(provider)
    else
      redirect_to admin_kiosks_path and return if @kiosk.save
      redirect_to new_admin_kiosk_path
    end
  end

  def edit
    @kiosk = Kiosk.find params[:id]
  end

  def update #MLM NOTES TO REFACTOR - Need different way to redirect user when approach from nested provider route vs top level route
    kiosk = Kiosk.find(params[:id])
    if params[:provider_id]
      provider = Provider.find(params[:provider_id])
      if kiosk.update(kiosk_params)
        redirect_to admin_provider_path(provider)
      else
        redirect_to edit_admin_provider_kiosk_path(provider,kiosk)
      end
    else
      if kiosk.update(kiosk_params)
        redirect_to admin_kiosks_path
      else
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
    params.require(:kiosk).permit(:name,:longitude, :latitude, :location_id, :provider_id)
  end
end
