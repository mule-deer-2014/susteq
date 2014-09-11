BigData.DataController = function(){
  this.kiosks = [];
  this.pumps = [];
  this.container = $('#chart-container');
};

BigData.DataController.prototype = {
  getChartData:function(dataToDisplay){
    var that = this;
    $.each(dataToDisplay, function(index, data){
      switch(data.chartType){
        case "bar":
          that.container.append(that.chartElementWriter(index));
          data.svgSelector = that.chartSelector(index);
          new HubChart.BarChart(data);
          // makeTable(data);
          break;
        case "stacked":
          that.container.append(that.chartElementWriter(index));
          data.svgSelector = that.chartSelector(index);
          new HubChart.StackedBarChart(data);
          that.createBarGraph(index, data);
          break;
        case "map":
          that.createMap(index, data.chartData);
          break;
      }
    });
  },

  createBarGraph: function(index, data){
    that = this;
    that.container.append(that.chartElementWriter(index));
    data.svgSelector = that.chartSelector(index);
    new HubChart.BarChart(data);
  },

  chartElementWriter: function(index) {
    return "<svg id='chart" + index + "'></svg>";
  },

  chartSelector: function(index) {
    return "#chart" + index;
  },

  createMap: function(index, data){
    that = this;
    that.createHubs(data)
    var LAT_LONG_NAIROBI = [-1.283285, 36.821657];
    that.mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
    that.mapView.displayHubs({kiosks:this.kiosks, pumps:this.pumps});
  },

  createHubs: function(data){
    this.parseJsonKioskData(data.kiosks);
    this.parseJsonPumpData(data.pumps);
  },

  parseJsonKioskData: function(kioskData){
    that = this;
    $.each(kioskData, function(index, kioskDatum){
      var kiosk = new Kiosk(kioskDatum);
      that.kiosks.push(kiosk);
    })
  },

  parseJsonPumpData: function(pumpData){
    that = this;
    $.each(pumpData, function(index, pumpDatum){
      var pump = new Pump(pumpDatum);
      that.pumps.push(pump);
    })
  },

};
