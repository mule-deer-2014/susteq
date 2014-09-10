BigData.DataController = function(){
  this.kiosks = [];
  this.pumps = [];
  this.chartLibrary = [];
};

var totalCreditsSold = new ChartItem({controllerName: "total_credits_sold", $divSelector:$('#total-credits-sold'), yAxisName: "Kiosk name"})


// var ChartLibrary = [...all_chart_items]

var ChartItem = function() {
  this.controllerName = "total_credits_sold",
  this.$divSelector = $("#total-credits-sold"),
  this.xAxisTitle = "Kiosk name",
  this.yAxisTitle = "Total credits sold"
},

ChartItem.prototype = {

  getChartData: function(){
    var chartAjax = $.ajax({
      url:"/transactions" + controllerMethodName + ".json",
      method:"get",
      success: this.generateChart
      error: this.loadFailed
    })
  },

  loadFailed:function(){
    alert("Error: data failed to load.");
  },

  generateChart:function(data){
    this.transactionData = data;
    this.makeChart({dataSet:data,yAxisTitle:this.yAxisTitle, xAxisTitle:this.xAxisTitle});
  },

  displayOnMap:function(){
    this.parseTransactionData();
  },
  checkForDiv:function(){
    if (this.$divSelector().length > 0)
      return true;
    else
      return false;
  },

  makeChart: function(object) {
    this.setData(dataset);
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

BigData.DataController.prototype = {

  generateMap: function(){
    if ($('#map').length > 0){
      var LAT_LONG_NAIROBI = [-1.283285, 36.821657];
      this.mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
      this.mapView.displayAllHubs({kiosks:this.kiosks, pumps:this.pumps});
    }
  },

  getChartData: function(controllerMethodName, callbackFn ){
    var chartAjax = $.ajax({
      url:"/transactions" + controllerMethodName + ".json",
      method:"get",
      success:callbackFn
      error:this.loadFailed
    })
  },

  generateAdminCharts:function(){
    $.each(ChartLibrary, function(index, chartItem)){
      if ($chartDiv.length > 0){
        this.getChartData(chartItem.controllerName, chartItem.callbackFn)
      }
    }

  },

  checkPermissions: function(func){
    var permissionAjax = $.ajax({
      url:"/sessions.json",
      method:"get",
      success:(func)
    })
  },

  getAdminHubData: function(func){
    var pumpAjax = $.ajax({
      url:"/admin/pumps.json",
      method:"get",
      success:this.parseJsonPumpData.bind(this)
    });
    var kioskAjax = $.ajax({
      url:"/admin/kiosks.json",
      method:"get",
      success:this.parseJsonKioskData.bind(this)
    });
    $.when(pumpAjax, kioskAjax).done(func)
  },

  parseJsonKioskData: function(kioskData){
    for(var i= 0; i<kioskData.length; i++){
      var kiosk = new Kiosk(kioskData[i].hub);
      this.kiosks.push(kiosk);
    }
  },

  parseJsonPumpData: function(pumpData){
    for(var i= 0; i<pumpData.length; i++){
      var pump = new Pump(pumpData[i].hub);
      this.pumps.push(pump);
    }
  },

  getProviderHubData: function(func){
    var pumpAjax = $.ajax({
      url:"/pumps.json",
      method:"get",
      success:this.parseJsonPumpData.bind(this),
    });
    var kioskAjax = $.ajax({
      url:"/kiosks.json",
      method:"get",
      success:this.parseJsonKioskData.bind(this),

    });
    $.when(pumpAjax, kioskAjax).done(func)
  },
}
