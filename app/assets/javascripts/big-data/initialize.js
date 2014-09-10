var LAT_LONG_NAIROBI = [-1.283285, 36.821657];

$(document).ready(function(){
  var dataController = new BigData.DataController();
  if (docCookies.getItem("remember_token")){
    dataController.checkPermissions(function(data){
      if (data.permission === "admin"){
        this.getAdminHubData(this.generateMap).bind(this);
        generateAdminCharts();
      }
      else{
        this.getProviderHubData(this.generateMap).bind(this);
        generateProviderCharts();
        }
      }
    }).bind(dataController);
  }
});
