class DashboardController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def dashboard
    @hubs = getHubs
    @viz_data = [@hubs].to_json
    render "dashboard/dashboard"
  end
end
