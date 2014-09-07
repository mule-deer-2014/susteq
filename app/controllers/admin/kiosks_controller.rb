class Admin::KiosksController < ApplicationController
  layout "admin_application"

  def index
    @kiosks = Kiosk.all
  end

  def new
    @kiosk = Kiosk.new
    @providers = Provider.all
  end

  def show
    @kiosk = Kiosk.find params[:id]
  end

  def create
    @kiosk = Kiosk.new(kiosk_params)
    if @kiosk.save
      redirect_to admin_kiosk_path(@kiosk)
    else
      render "admin/kiosks/new"
    end
  end

  def edit
    @kiosk = Kiosk.find params[:id]
  end

  def update
    @kiosk = Kiosk.find params[:id]
    if @kiosk.update_attributes(kiosk_params)
      redirect_to admin_kiosk_path(@kiosk)
    else
      render "admin/kiosks/edit"
    end
  end

  def destroy
    provider = Provider.find( (Kiosk.find(params[:id])).provider_id )
    Kiosk.destroy(params[:id])
    redirect_to provider_path(provider)
  end



  private

  def kiosk_params
    params.require(:kiosk).permit(:longitude, :latitude, :location_id, :provider_id)
  end

end
