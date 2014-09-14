var PumpsController = Paloma.controller('Admin/Pumps');

PumpsController.prototype.show = function(){
  that = this;
  $(document).ready(function(){
    var dataController = new BigData.DataController();
    dataController.getChartData(that.params["viz_data"])
  });
}