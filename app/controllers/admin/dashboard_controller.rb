class Admin::DashboardController < ApplicationController
  include PerspectiveSummary
  layout "admin_application"
  before_filter :require_admin_signin

  def main
    @new_hubs_ids = (Transaction.all - Hub.get_all_transactions)
    .map{ |transaction| transaction.location_id }

    hubs = getHubs

    @viz_data = [hubs].to_json
  end

  def operations
  end
end
