class HubsController < ApplicationController
  def index
    @provider = Provider.find(params[:provider_id])
    @pumps = @provider.pumps
    @kioks = @provider.kiosks
  end
end