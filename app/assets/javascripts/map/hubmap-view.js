HubMap.View = function(startLat, startLong, startZoom){
  this.map = L.map('map').setView([startLat,startLong], startZoom);
};

HubMap.View.prototype = {
  greenMarker: L.AwesomeMarkers.icon({
    icon: 'circle',
    markerColor: 'green'
  }),

  redMarker: L.AwesomeMarkers.icon({
    icon: 'circle',
    markerColor: 'red'
  }),

  setEsriTileLayer: function(){
    L.esri.basemapLayer("Imagery").addTo(this.map);
  },

  setOSMTileLayer: function(){
    var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    new L.TileLayer(osmUrl).addTo(this.map);
  },

  initializeMap: function(lat,longi, zoom){
    this.map = L.map('map').setView([lat, longi], zoom);
  },

  createMarker: function(hub){
    var icon;
    hub.status === "ok" ? icon = this.greenMarker : icon = this.redMarker;
    return L.marker([hub.latitude, hub.longitude], {icon:icon});
  },

  createPopUp: function(hub){
    return L.popup().setContent('<p>'+ hub.name +'<br /> Water price: $' + hub.waterPrice + '.</p>');
  },

  createErrorPopUp: function(hub){
    return L.popup().setContent('<p>'+ hub.name +'<br /> Water price: $' + hub.waterPrice + '<br/>'+ 'Warning: ' + hub.errors + '</p>');
  },

  makePopUp: function(hub){
    if (hub.status === "ok")
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
  }
};
