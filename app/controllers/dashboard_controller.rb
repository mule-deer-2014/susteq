class DashboardController < ApplicationController
  layout "provider_application"
  before_filter :require_employee_signin

  def dashboard
    @hubs = Provider.find(current_provider).hubs
    render "dashboard/dashboard"
  end
end
