class ProvidersController < ApplicationController
  def show
    @provider = Provider.find(params[:id])
    @pumps = @provider.pumps
    @kiosks = @provider.kiosks
  end
end