//Initialize Map
//Take in data
//parse JSON data and initialize models
//Create markers
//Create popups
//set event listeners
//Render markers

HubMap.Controller = function(view){
  this.view = view;
  this.hubs = [];
};

HubMap.Controller.prototype = {

  populateMap: function(){
    var getHubData = $.ajax({
      url:"/hubs",
      method:"get"
    }).
    done(function(){
      this.parseJsonHubData.bind(this);
      this.view.renderMarkers(this.hubs);
    }).
    fail();
  },

  parseJsonHubData: function(jsonData){
    for (var i= 0; i<jsonData.length; i++){
      var hubJsonData = jsonData[i];
      if (hubJsonData.latitude && hubJsonData.longitude){
        hub = new Hub(hubJsonData);
        this.hubs.push(hub);
      }
    }
  },



};

testData = {id:"2", name:"Roger Moooore", created_at:"10/20/2014", town:"Kibera", postalCode:"93420", province:"Eastern", country:"Kenya", latitude:34.06543, longitude:-4.96194, waterPrice:2.02, status:"ok"}

testData1 = {id:"1", name:"Sean COOONery", created_at:"10/3/2014", town:"Kibera", postalCode:"93420", province:"Eastern", country:"Kenya", latitude:34.06545, longitude:-4.96104, waterPrice:8.02, status:"not ok"}

var mapView = new HubMap.View(34.06543, -4.96194, 15);
mapView.setEsriTileLayer();
var mapController = new HubMap.Controller(mapView);
mapController.parseJsonHubData([testData, testData1])
mapController.view.renderMarkers(mapController.hubs)
