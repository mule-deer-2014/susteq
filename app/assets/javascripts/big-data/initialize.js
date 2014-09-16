BigData.initialize = function(){
    var dataController = new BigData.DataController();
    dataController.getChartData(that.params.viz_data)
  };