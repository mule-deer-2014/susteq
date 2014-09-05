HubMap.View = function(startLat, startLong, startZoom){
  this.map = L.map('map').setView([startLat,startLong], startZoom);
};

HubMap.View.prototype = {
  greenMarker: L.AwesomeMarkers.icon({
    markerColor: 'green'
  }),

  redMarker: L.AwesomeMarkers.icon({
    icon: 'circle',
    markerColor: 'red'
  }),

  setEsriTileLayer: function(){
    L.esri.basemapLayer("Streets").addTo(this.map);
  },

  initializeMap: function(lat,longi, zoom){
    this.map = L.map('map').setView([lat, longi], zoom);
  },

  renderMarkers:function(hubs){
    for (var i=0; i<hubs.length; i++){
      if hubs[i]
      var marker = L.marker([hubs[i].latitude, hubs[i].longitude], {icon:this.greenMarker})
      popup = L.popup()
        .setContent('<p>'+ hubs[i].name +"<br /> Water price: $" + hubs[i].waterPrice + ".</p>")
      marker.bindPopup(popup).addTo(this.map);
      marker.on("click", marker.openPopup);
    }
  }
};
