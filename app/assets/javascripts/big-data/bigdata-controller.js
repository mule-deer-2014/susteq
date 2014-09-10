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
          that.createBarGraph(index, data);
          break;
        case "map":
          that.createMap(index, data);
          break;
      }
    });
  },

  chartElementWriter: function(index) {
    return "<svg id='chart" + index + "'></svg>";
  },

  chartSelector: function(index) {
    return "#chart" + index;
  }
};