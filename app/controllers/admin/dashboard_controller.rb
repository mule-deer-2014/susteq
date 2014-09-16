class Admin::DashboardController < ApplicationController
  include PerspectiveSummary
  layout "admin_application"
  before_filter :require_admin_signin

  def main
    @sms = sms_balance_by_pump_table
    @total_credits_sold = credits_by_kiosk_for_all_table
    @total_water = dispensed_by_pump_for_all_table[:chartData]
    @shopkeepers_credit = credits_remaining_by_kiosk_table
    # @error_codes = errors_by_hub
    js :viz_data => [credits_by_kiosk_by_month, credits_bought_by_kiosk,credits_remaining_by_kiosk, dispensed_by_pump_by_month, errors_by_hub, getHubs]
    @new_hubs_ids = (Transaction.all - Hub.get_all_transactions).map { |transaction| transaction.location_id }.uniq
  end
end
