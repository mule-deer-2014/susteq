HubChart.BarChart = function(object) {
  Morris.Bar({
    element: object.divSelector,
    data: object.chartData,
    xkey: 'location_id',
    ykeys: ['total'],
    labels: object.yAxisTitle,
  });
};

HubChart.StackedBarChart = function(object) {
  Morris.Bar({
    element: object.divSelector,
    data: object.chartData,
    stacked: true,
    xkey: 'location_id',
    ykeys: ['total'],
    labels: object.yAxisTitle,
  });
};

HubChart.LineChart = function(object) {
  Morris.Line({
    element: object.divSelector,
    data: object.chartData,
    xkey: 'location_id',
    ykeys: ['total'],
    labels: object.yAxisTitle,
  });
};