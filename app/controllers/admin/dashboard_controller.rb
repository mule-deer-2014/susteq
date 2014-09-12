class Admin::DashboardController < ApplicationController
  include PerspectiveSummary
  layout "admin_application"
  before_filter :require_admin_signin

  def main
    @sms = sms_balance_by_pump_table
    # @last_transaction
    @total_credits_sold = credits_by_kiosk_for_all_table
    @shop_bought = credits_bought_by_kiosk_table
    @total_water = dispensed_by_pump_for_all_table
    @shopkeepers_credit = credits_remaining_by_kiosk_table
    # @error_codes = # for thirty days
    @viz_data = [getHubs].to_json
    @new_hubs_ids = (Transaction.all - Hub.get_all_transactions).map { |transaction| transaction.location_id }.uniq
  end
end
