//Initialize Map
//Take in data
//initialize models
//Create markers
//Create popups
//set event listeners
//Render markers

HubMap.Controller = function(view){
  this.view = view;
  this.hubs = [];
};

HubMap.Controller.prototype = {
  populateMap:function(){
    $.ajax({
      url:,
      method:"get"
    })
    .done(parseJsonHubData)
    .fail(alert(Failed to fetch water hub data!));
  },

  parseJsonHubData: function(jsonData){
    for (var i= 0; i<jsonData.length, i++){
      var hubJsonData = jsonData[i];
      if (hubJsonData.latitude && hubJsonData.longitude)
        this.hubs.push(new Hub(hubJsonData));
    }
  },




};

var mapView = new HubMap.View(34.06543, -4.96194, 15);
mapView.setEsriTileLayer();
var mapController = HubMap.Controller(mapView);