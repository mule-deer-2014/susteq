class Admin::OperationsController < ApplicationController
	layout "admin_application"

	def index
    @sms = sms_balance_by_pump_table
    @total_credits_sold = credits_by_kiosk_for_all_table
    @total_water = dispensed_by_pump_for_all_table(true)
    @shopkeepers_credit = credits_remaining_by_kiosk_table
    @credits_bought = credits_bought_by_kiosk(true)
    # @error_codes = errors_by_hub
  end
end
