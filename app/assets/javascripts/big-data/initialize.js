// var LAT_LONG_NAIROBI = [-1.283285, 36.821657];
var dataToDisplay = [{xAxisTitle: "Kiosk Location Id",
                      yAxisTitle: "Credits Sold",
                      chartData: [{location_id:14, total:2000},
                                {location_id: 11, total:1400},
                                {location_id: 4, total: 2300},
                                {location_id: 7, total:300}],
                      chartType: "bar"}];
$(document).ready(function(){
  var dataController = new BigData.DataController();
    dataController.getChartData(dataToDisplay);
});
