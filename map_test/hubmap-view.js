HubMap.View = function(startLat, startLong, startZoom){
  this.map = L.map('map').setView([startLat,startLong], startZoom);
};

HubMap.View.prototype = {

  setEsriTileLayer: function(){
    L.esri.basemapLayer("Imagery").addTo(this.map);
  },

  initializeMap: function(lat,longi, zoom){
    this.map = L.map('map').setView([lat, longi], zoom);
  }
};
