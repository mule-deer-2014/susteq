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
    @pump = Pump.new(pump_params)
    # @providers = Provider.find(pump_params)
    if @pump.save
      redirect_to admin_pump_path(@pump)
    else
      render "admin/pumps/new"
    end
  end

  def index
    @pumps = Pump.all
    respond_to do |format|
      format.html {render '/pumps/index'}
      format.json {render json:Pump.get_all_with_transactions}
    end
  end

  def edit
    @pump = Pump.find params[:id]
  end

  def update
    @pump = Pump.find params[:id]
    if @pump.update_attributes(pump_params)
      redirect_to admin_pump_path(@pump)
    else
      render "admin/pumps/edit"
    end

  end

  def destroy
    provider = Provider.find( (Pump.find(params[:id])).provider_id )
    Pump.destroy(params[:id])
    redirect_to admin_pumps_path
  end



  private

  def pump_params
    params.require(:pump).permit(:longitude, :latitude, :location_id, :provider_id)
  end

end

