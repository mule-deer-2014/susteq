// HubChart.BarChart = function(object) {
//   debugger
//   Morris.Bar({
//     element: object.divSelector,
//     data: object.chartData,
//     xkey: object.xKey,
//     ykeys: [object.yKey],
//     labels: object.yAxisTitle
//   });
// };

HubChart.BarChart = function(object){
  var chart = nv.models.discreteBarChart()
      .x(function(d) { return d.label })
      .y(function(d) { return d.value })
      .staggerLabels(false)
      .tooltips(false)
      .showValues(true)
      .transitionDuration(350)
      ;

  d3.select(object.divSelector)
      .datum(object.chartData)
      .call(chart);

  nv.utils.windowResize(chart.update);

  return chart;
};

HubChart.StackedBarChart = function(object){
  var chart = nv.models.multiBarChart()
    .transitionDuration(350)
    .reduceXTicks(true)
    .rotateLabels(0)
    .showControls(true)
    .groupSpacing(0.1)
  ;

  chart.yAxis
    .tickFormat(d3.format(',.1f'));

  d3.select(object.divSelector)
    .datum(object.chartData)
    .call(chart);

  nv.utils.windowResize(chart.update);

  return chart;
};

// HubChart.StackedBarChart = function(object) {
//   Morris.Bar({
//     element: object.divSelector,
//     data: object.chartData,
//     stacked: true,
//     xkey: object.xKey,
//     ykeys: object.yKeys,
//     labels: object.yAxisTitle
//   });
// };

HubChart.LineChart = function(object) {
  Morris.Line({
    element: object.divSelector,
    data: object.chartData,
    xkey: object.xKey,
    ykeys: [object.yKey],
    labels: object.yAxisTitle
  });
};