class Admin::DashboardController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def main
    @new_hubs_ids = (Transaction.all - Hub.get_all_transactions).map { |transaction| transaction.location_id }

    @viz_data = [PerspectiveSummary.new.getHubs].to_json
  end

  def operations
  end
end
