$(document).ready(function() {
  var LAT_LONG_NAIROBI = [-1.283285, 36.821657];
  if ($("#map")){
    var mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
    mapView.setOSMTileLayer();
    var mapController = new HubMap.Controller(mapView);
    mapController.adminGetKioskData();
    mapController.adminGetPumpData();
  }
});