class Admin::ProvidersController < ApplicationController
  respond_to :html

  def index
    @providers = Provider.all
  end

  def create
    @provider = Provider.create(provider_params)
    redirect_to admin_providers_path
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
  end

  def update
    @provider = Provider.find(params[:id])
    @provider.update(provider_params)
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
