class KiosksController < ApplicationController

  def show
    @kiosk = Kiosk.find params[:id]
  end

  def create
    @kiosk = Kiosk.new(kiosk_params)
    @provider = Provider.find(params[:provider_id])
    @provider.kiosks << @kiosk
    if @kiosk.save
      redirect_to kiosk_path(@kiosk)
    else
      render "kiosks/new"
    end
  end


  def edit
    @kiosk = Kiosk.find params[:id]
  end

  def update
    @kiosk = Kiosk.find params[:id]
    if @kiosk.update_attributes(kiosk_params)
      redirect_to kiosk_path(@kiosk)
    else
      render "kiosks/edit"
    end

  end

  def destroy
    Kiosk.destroy(params[:id])
  end



  private

  def kiosk_params
    params.require(:hub).permit(:longitude, :latitude, :location_id, :provider_id)
  end


end
