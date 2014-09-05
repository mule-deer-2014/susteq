//Map Module using Leaflet API

//Initialize Map
//Take in data
//Create markers
//Create popups
//set event listeners
//Render markers

  HubMap.Controller = function (){
  };

  HubMap.Controller.prototype = {

    initializeMap: function(lat,longi, zoom){
      this.map = L.map('map').setView([lat, longi], zoom);
    },

    setEsriTileLayer: function(){
      L.esri.basemapLayer("Imagery").addTo(this.map);
    }

  }



  function MapController(){};

  MapController.prototype = {

    initializeMap: function(lat,longi, zoom){
      this.map = L.map('map').setView([lat, longi], zoom);
    },

    setEsriTileLayer: function(){
      L.esri.basemapLayer("Imagery").addTo(this.map);
    },

});


VendorMap.Controller = function(view){
  this.view = view
  this.vendorList = []
  this.displayList = []
}

VendorMap.Controller.prototype = {

  addAllEventListeners: function() {
    this.view.map.on('zoomend', this.populateDisplay.bind(this))
    this.view.map.on('dragend', this.populateDisplay.bind(this))
    this.view.searchNearbyButton.on('click', this.directView.bind(this))
  },

//For Populating Vendors as Clusters
  populateMap: function(){
    $.ajax({
      url: '/vendors',
      type: 'GET',
    }).done(function(data){
      var vendorJsonObjectsCollection = JSON.parse(data)
      this.populateVendorListFromJSON(vendorJsonObjectsCollection)
      this.renderView()
    }.bind(this)).fail(function() {
    })
  },

  populateVendorListFromJSON: function(vendorJsonObjectsCollection){
    console.log(vendorJsonObjectsCollection.length)
    for(var i=0; i<vendorJsonObjectsCollection.length; i++){
      var vendorJsonObject = vendorJsonObjectsCollection[i]
      if(vendorJsonObject.latitude && vendorJsonObject.longitude){
        vendorJSObject = new VendorMap.Vendor(vendorJsonObject)
        this.vendorList.push(vendorJSObject)
      }
    }
  },

  renderView: function(vendorList){
    this.view.renderMarkers(this.vendorList)
    this.view.renderStats(this.vendorList.length)
  },

//For search bar
  directView: function(event) {
    event.preventDefault();
    $.ajax({
      url: '/location',
      type: 'POST',
      data: $('form').serialize()
    }).done(function(data){
      if(data.length == 0) {
        alert("Your location could not be found. Please try again.") }
      else {
        var data = JSON.parse(data)
        var southWest = L.latLng(data["southwest"]["lat"], data["southwest"]["lng"])
        var northEast = L.latLng(data["northeast"]["lat"], data["northeast"]["lng"])
        var bounds = L.latLngBounds(southWest, northEast)
        var center_coords = bounds.getCenter()
        this.view.map.setView(center_coords,14)
        this.populateDisplay()
        $('.search-nearby-field').value = "Enter Your Location"
      }
    }.bind(this)).fail(function(){
      alert("Your location could not be found. Please try again.")
    })
  },

//For Sidebar Display
  populateDisplay: function() {
    this.displayList = []
    this.view.setCurrentBounds()
    for(i=0;i<this.vendorList.length;i++) {
      if(this.checkForInView(this.vendorList[i])) {
        this.displayList.push(this.vendorList[i])
      }
    }
    this.view.renderDisplay(this.displayList)
  },

  checkForInView: function(vendorJSObject) {
    var lat_test = vendorJSObject.latitude >= this.view.southWestBoundLat && vendorJSObject.latitude <= this.view.northEastBoundLat
    var lng_test = vendorJSObject.longitude >= this.view.southWestBoundLng && vendorJSObject.longitude <= this.view.northEastBoundLng
    return lat_test && lng_test
  }

}