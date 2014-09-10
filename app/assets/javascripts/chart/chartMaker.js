var ChartItem = function(object) {
  this.controllerMethod = object.controllerMethod;
  this.$divSelector = object.$divSelector;
  this.xAxisTitle = object.xAxisTitle;
  this.yAxisTitle = object.yAxisTitle;
};

ChartItem.prototype = {
  createChart: function(){
    var chartAjax = $.ajax({
      url:"/admin/" + this.controllerMethod + ".json",
      method:"get",
      success: this.makeChart,
      error: this.loadFailed
    })
  },

  loadFailed:function(){
    alert("Error: data failed to load.");
  },

  displayOnMap:function(){
  },

  checkForDiv:function(){
    if (this.$divSelector().length > 0)
      return true;
    else
      return false;
  },

  makeChart: function(data) {
    this.setData(data);
    this.setScales();
    this.setAxes();
    this.drawChart(title, xAxisTitle);
  },

  getAmount: function(d) { return d.amount; },

  getId:     function(d) { return d.location_id; },

  setData:   function(jsonData) {
    this.data = jsonData.slice();
    this.dataLength = jsonData.length;
    this.barWidth = this.width / this.dataLength;
  },

  setScales: function() {
    this.setYScale();
    this.setXScale();
  },

  setAxes: function() {
    var that = this;
    this.setXAxis();
    this.setYAxis();
  },

  setYScale: function() {
    var that = this;
    this.y = d3.scale.linear()
               .domain([0, d3.max(that.data, that.getAmount)])
               .range([that.height,0]);
  },

  setXScale: function() {
    var that = this;
    this.x = d3.scale.ordinal()
    .domain(that.data.map(function(d) { return d.location_id; }))
    .rangeRoundBands([0, that.width]);
  },

  setXAxis: function() {
    var that = this;
    this.xAxis = d3.svg.axis()
    .scale(that.x)
    .orient("bottom")
    .ticks(that.dataLength, "id");
  },

  setYAxis: function() {
    var that = this;
    this.yAxis = d3.svg.axis()
    .scale(that.y)
    .orient("left");
  },
};