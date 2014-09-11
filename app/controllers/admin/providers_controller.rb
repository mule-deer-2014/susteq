class Admin::ProvidersController < ApplicationController
  layout "admin_application"
  respond_to :html
  before_filter :require_admin_signin

  def index
    @viz_data = 0
    @providers = Provider.all
  end

  def create
    @provider = Provider.create!(provider_params)
    redirect_to admin_providers_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_admin_provider_path(@provider)
  end

  def new
    @viz_data = 0
    @provider = Provider.new
  end

  def edit
    @viz_data = 0
    @provider = Provider.find(params[:id])
  end

  def show
    @viz_data = 0
    @provider = Provider.find(params[:id])
    @hubs = @provider.hubs
    @pumps = @hubs[:pumps]
    @kiosks = @hubs[:kiosks]
    @employees = @provider.employees
  end

  def update
    @provider = Provider.find(params[:id])
    @provider.update!(provider_params)
    redirect_to admin_providers_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to admin_providers_path
  end

  def destroy
    Provider.destroy(params[:id])
    redirect_to admin_providers_path
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :address, :country, :duns_number)
  end
end
