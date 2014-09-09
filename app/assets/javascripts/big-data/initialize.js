var LAT_LONG_NAIROBI = [-1.283285, 36.821657];

$(document).ready(function(){
  var dataController = new BigData.DataController();
  if (docCookies.getItem("remember_token")){
    dataController.checkPermissions(function(data){
      if (data.permission === "admin"){
        dataController.getAdminData(function(){
          if ($('#map').length > 0){
            this.mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
            this.mapView.displayAllHubs({kiosks:this.kiosks, pumps:this.pumps});
          }
          if ($("#kiosk-charts").length > 0 || $("#pump-charts").length > 0){
            this.grapher = new HubChart.ChartMaker();
            this.grapher.makeDataForHubs(dataController.allHubs());
            this.grapher.makeCharts();
          }
        }.bind(dataController));
      }
      else{
        dataController.getProviderData(function(){
          if ($('#map').length > 0){
            this.mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
            this.mapView.displayAllHubs({kiosks:this.kiosks, pumps:this.pumps});
          }
        }.bind(dataController));
      }
    });
  }
});
