class DashboardController < ApplicationController
  include PerspectiveSummary
  layout "provider_application"
  before_filter :require_employee_signin

  def main
    @viz_data = [getHubs].to_json
    render "dashboard/main"
  end
end
