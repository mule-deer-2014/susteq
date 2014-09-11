class TestsController < ApplicationController
  def test
    @pump = Pump.first
    @kiosk = Kiosk.first
    @provider = Provider.first
    @viz_data_pump = dispensed_by_month(@pump)
    @viz_data_kiosk = credits_by_month(@kiosk)
    @viz_data_credits_by_month = credits_by_kiosk_by_month
    @viz_data_credits_by_kiosk = credits_by_kiosk_for_all
    @viz_data_credits_by_kiosk_for_provider = credits_by_kiosk_for_provider(@provider)
    @viz_data_dispensed_by_pump_for_provider = dispensed_by_pump_for_provider(@provider)
    @viz_data_credits_bought_by_kiosk = credits_bought_by_kiosk
    render 'test'
  end
end
