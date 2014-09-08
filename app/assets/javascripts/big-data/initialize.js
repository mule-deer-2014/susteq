var LAT_LONG_NAIROBI = [-1.283285, 36.821657];

$(document).ready(function(){
  var dataController = new BigData.DataController();
  if (docCookies.getItem("remember_token")){
    dataController.checkPermissions(function(data){
      if ($('#map').length > 0)
        dataController.mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
      if (data.permission === "admin"){
        dataController.getAdminData(function(){
          this.mapView.displayAllHubs({kiosks:this.kiosks, pumps:this.pumps});
          this.grapher.makeDataForHubs(this.allHubs());
          this.grapher.makeCharts();
        }.bind(dataController));
      }
      else{
        dataController.getProviderData(function(){
          this.mapView.displayAllHubs({kiosks:this.kiosks, pumps:this.pumps});
        }.bind(dataController));
      }
    });
  }
});