class Admin::DashboardController < ApplicationController
  layout "admin_application"
  before_filter :require_admin_signin

  def main
    @new_hubs_ids = (Transaction.all - Hub.get_all_transactions).map { |transaction| transaction.location_id }
    @viz_data = [{xAxisTitle: 'Kiosk Location Id',
  yAxisTitle: 'Credits Sold',
  chartData: [{location_id:14, total:2000},
  {location_id: 11, total:1400},
  {location_id: 4, total: 2300},
  {location_id: 7, total:300}],
chartType: 'bar'}].to_json
  end
  
  def operations
  end
end
