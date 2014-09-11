module PerspectiveSummary
  include ApplicationHelper
  def getHubs
    if admin_signed_in?
      kiosks = Kiosk.all
      pumps = Pump.all
    else
      kiosks = current_provider.kiosks
      pumps = current_provider.kiosks
    end
    {chartData: {kiosks: kiosks, pumps: pumps},
                  chartType: "map" }
  end
end