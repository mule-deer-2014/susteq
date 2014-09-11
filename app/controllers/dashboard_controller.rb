class DashboardController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def main
    @hubs = current_provider.hubs
    render "dashboard/main"
  end
end
