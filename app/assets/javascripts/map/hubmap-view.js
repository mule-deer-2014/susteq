HubMap.View = function(startLat, startLong, startZoom){
  this.map = L.map('map').setView([startLat,startLong], startZoom);
  this.setTileLayers();
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
    var icon;
    switch(hub.status_code){
    case 1:
      icon = this.greenMarker;
      break;
    case 0:
      icon = this.orangeMarker;
      break;
    case -1:
      icon = this.redMarker;
      break;
    }
    return L.marker([hub.latitude, hub.longitude], {icon:icon});
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

  renderMarkers:function(hubs){
    for (var i=0; i<hubs.length; i++){
      var marker = this.createMarker(hubs[i]);
      var popup = this.makePopUp(hubs[i]);
      marker.bindPopup(popup).addTo(this.map);
      marker.on("click", marker.openPopup);
    }
  },

  createMarkers:function(hubs){
    markers = [];
    for (var i=0; i<hubs.length; i++){
      var marker = this.createMarker(hubs[i]);
      var popup = this.makePopUp(hubs[i]);
      marker.bindPopup(popup);
    }
    return markers;
  },

  renderPumpsLayer: function(pumps){
    var pumpMarkers = this.createMarkers(pumps);
    var pumpLayer =  L.layerGroup(pumpMarkers);
    console.log(pumpLayer);
    var overLay = {"Pumps": pumpLayer};
    L.control.layers(null, overLay).addTo(this.map);

  },

  renderKiosksLayer: function(kiosks){
    var kioskMarkers = this.createMarkers(kiosks);
    var kioskLayer = L.layerGroup(kioskMarkers);
    L.control.layers(null, kioskLayer).addTo(this.map);
  }

};
