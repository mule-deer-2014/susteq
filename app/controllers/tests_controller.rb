class TestsController < ApplicationController
  def test
    @pump = Pump.first
    @kiosk = Kiosk.first
    @provider = Provider.first
    @viz_data_pump = dispensed_by_month(@pump).to_json
    @viz_data_kiosk = credits_by_month(@kiosk).to_json
    @viz_data_credits_by_month = credits_by_kiosk_by_month.to_json
    @viz_data_credits_by_kiosk = credits_by_kiosk_for_all.to_json
    @viz_data_credits_by_kiosk_for_prgovider = credits_by_kiosk_for_provider(@provider).to_json
    @viz_data_dispensed_by_pump_for_provider = dispensed_by_pump_for_provider(@provider).to_json
    @viz_data_credits_bought_by_kiosk = credits_bought_by_kiosk.to_json
    @viz_data_credits_remaining_by_kiosk = credits_remaining_by_kiosk.to_json
    @viz_data_dispensed_by_pump_for_all = dispensed_by_pump_for_all_table.to_json
    @viz_data_credits_bought_by_kiosk_table = credits_bought_by_kiosk_table
    @viz_data_credits_remaining_by_kiosk_table  = credits_remaining_by_kiosk_table
    @viz_data_sms_balance_by_pump = sms_balance_by_pump
    render 'test'
  end
end
