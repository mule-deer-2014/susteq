class DashboardController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def main
    @viz_data = 0
    @hubs = current_provider.hubs
    render "dashboard/main"
  end
end
