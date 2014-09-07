class ProvidersController < ApplicationController
  layout "provider_application"

  def dashboard
    @hubs = Provider.find(params[:provider_id]).hubs
    render "providers/dashboard/dashboard"
  end
end
