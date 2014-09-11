class PerspectiveSummary
  def getHubs
    {chartData: {kiosks: Kiosk.all, pumps: Pump.all},
                    chartType: "map" }
  end
end