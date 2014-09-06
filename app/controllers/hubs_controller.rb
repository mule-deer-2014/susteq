class HubsController < ApplicationController
  def index
    @provider = Provider.find(params[:id])
    @pumps = @provider.pumps
    @kioks = @provider.kiosks
  end

end