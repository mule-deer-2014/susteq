class Admin::ProvidersController < ApplicationController
  layout "admin_application"
  include PerspectiveSummary
  respond_to :html
  before_filter :require_admin_signin

  def index
    @providers = Provider.all
    hubs = getHubs
    @viz_data = [hubs].to_json
  end

  def create
    @provider = Provider.create!(provider_params)
      redirect_to admin_providers_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      redirect_to new_admin_provider_path(@provider)
  end

  def new
    @provider = Provider.new
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def show
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
