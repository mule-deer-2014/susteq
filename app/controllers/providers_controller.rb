class ProvidersController < ApplicationController
  def show
    @provider = Provider.find(params[:id])
    @hubs = @provider.hubs
  end
end