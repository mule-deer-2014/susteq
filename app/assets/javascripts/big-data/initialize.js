$(document).ready(function(){
  var dataController = new BigData.DataController();
  dataController.adminGetKioskData();
  dataController.adminGetPumpData();
});