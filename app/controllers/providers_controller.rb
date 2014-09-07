class ProvidersController < ApplicationController
  layout "provider_application"

  def dashboard
    @hubs = Provider.find(params[:id]).hubs
    render "providers/dashboard/dashboard"
  end
end
