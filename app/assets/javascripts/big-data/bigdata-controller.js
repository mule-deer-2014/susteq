BigData.DataController = function(){
  this.kiosks = [];
  this.pumps = [];
};

BigData.DataController.prototype = {
  getChartData:function(dataToDisplay){
    $.each(dataToDisplay, function(index, data){
      switch(data.chartType){
        case "bar":
        new HubChart.BarChart(data)
      }
    });
  }
};