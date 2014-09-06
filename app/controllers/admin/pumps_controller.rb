class Admin::PumpsController < ApplicationController

  def new
    @pump = Pump.new
  end

  def show
    @pump = Pump.find params[:id]
  end

  def create
    @pump = Pump.new(pump_params)
    @provider = Provider.find(params[:provider_id])
    @provider.pumps << @pump
    if @pump.save
      redirect_to pump_path(@pump)
    else
      render "pumps/new"
    end
  end


  def edit
    @pump = Pump.find params[:id]
  end

  def update
    @pump = Pump.find params[:id]
    if @pump.update_attributes(pump_params)
      redirect_to pump_path(@pump)
    else
      render "pumps/edit"
    end

  end

  def destroy
    Pump.destroy(params[:id])
  end



  private

  def pumps_params
    params.require(:pump).permit(:longitude, :latitude, :location_id, :provider_id)
  end

  # def hubs_params(type)
  #   case type
  #   when "kiosk"
  #     params.require(:kiosk).permit(:longitude, :latitude, :location_id, :provider_id)
  #   when "pump"
  #     params.require(:pump).permit(:longitude, :latitude, :location_id, :provider_id)
  #   end
  # end
end

