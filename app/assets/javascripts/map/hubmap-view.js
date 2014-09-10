HubMap.View = function(startLat, startLong, startZoom){
  this.map = L.map('map').setView([startLat,startLong], startZoom);
  this.setTileLayers();
  this.bindEvents();
};

HubMap.View.prototype = {

  setTileLayers: function(){
    var satLayer = L.esri.basemapLayer("Imagery");
    var osmLayer = new L.TileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png');
    var baseLayers = {"Satellite": satLayer, "Open Street Maps": osmLayer };
    L.control.layers(baseLayers, null, {collapsed:false}).addTo(this.map);
    satLayer.addTo(this.map);
  },

  createMarker: function(hub){
    icon =  L.AwesomeMarkers.icon({prefix:"fa"});
    icon.options.icon = this.getSymbol(hub);
    icon.options.markerColor = this.getStatus(hub);
    return L.marker([hub.latitude, hub.longitude], {icon:icon, riseOnHover:true});
  },

  createMarkers:function(hubs){
    markers = [];
    for (var i=0; i<hubs.length; i++){
      var marker = this.createMarker(hubs[i]);
      var popup = this.makePopUp(hubs[i]);
      markers.push(marker.bindPopup(popup));
    }
    return markers;
  },

  getStatus:function(hub){
    switch(hub.status_code){
    case 1:
      return "green";
      break;
    case 0:
      return "orange";
      break;
    case -1:
      return "red";
      break;
    }
  },

  getSymbol:function(hub){
    if (hub.type === "pump")
      return "tint";
    else
      return "home";
  },

  createPopUp: function(hub){
    return L.popup().setContent('<p>'+ hub.name +'<br />' + hub.type +'.</p>');
  },

  createErrorPopUp: function(hub){
    return L.popup().setContent('<p>'+ hub.name +'<br />' + hub.type +'</p>');
  },

  makePopUp: function(hub){
    if (hub.status === 1)
      return this.createPopUp(hub);
    else
      return this.createErrorPopUp(hub);
  },

  showPumpsLayer: function(){
    this.pumpsLayer.addTo(this.map);
  },

  showKiosksLayer: function(){
    this.kiosksLayer.addTo(this.map);
  },

  showAllHubs: function(){
    this.showPumpsLayer();
    this.showKiosksLayer();
  },

  createHubLayers: function(hubs){
    var markers = this.createMarkers(hubs)
    return L.layerGroup(markers);
  },

  renderHubsOnMap: function(hubs){
    this.pumpsLayer = this.createHubLayers(hubs.pumps);
    this.kiosksLayer =  this.createHubLayers(hubs.kiosks);
    L.control.layers(null, {"Kiosks":this.kiosksLayer, "Pumps":this.pumpsLayer}, {collapsed:false}).addTo(this.map);
  },

  displayAllHubs: function(hubs){
    this.renderHubsOnMap(hubs);
    this.showAllHubs();
  },

  toggleMapDisplay:function(){
    $("#map").slideToggle();
    if ($(".map-button").html() == "Hide Map")
      $(".map-button").html("Show Map");
    else
      $(".map-button").html("Hide Map");
  },

  addToggleMapEventListener:function(){
    $(".map-button").on("click", this.toggleMapDisplay);
  },

  bindEvents:function(){
    this.addToggleMapEventListener();
  }

};
