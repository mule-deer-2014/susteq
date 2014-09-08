var LAT_LONG_NAIROBI = [-1.283285, 36.821657];

$(document).ready(function(){
  var dataController = new BigData.DataController();
  dataController.mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
  dataController.mapView.setOSMTileLayer();
  dataController.getAdminData(function(){
    this.mapView.renderMarkers(this.allHubs());
  }.bind(dataController));
});
