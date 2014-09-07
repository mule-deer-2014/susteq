HubMap.Controller = function(view){
  this.view = view;
  this.kiosks = [];
  this.pumps = [];
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

  adminGetKioskData: function(){
    var kioskAjax = $.ajax({
      url:"/admin/kiosks.json",
      method:"get"
    }).
    done(function(data){
      this.parseJsonKioskData(data.kiosks);
      this.view.renderMarkers(this.kiosks);
    }.bind(this)).
    fail();
  },

  parseJsonKioskData: function(kioskData){
    for(var i= 0; i<kioskData.length; i++){
      if (kioskData[i].latitude && kioskData[i].longitude){
        var kiosk = new Kiosk(kioskData[i]);
        this.kiosks.push(kiosk);
      }
    }
  },

  adminGetPumpData: function(){
    var pumpAjax = $.ajax({
      url:"/admin/pumps.json",
      method:"get"
    }).
    done(function(data){
      console.log(data);
      this.parseJsonPumpData(data.pumps);
      this.view.renderMarkers(this.pumps);
    }.bind(this)).
    fail();
  },

  parseJsonPumpData: function(pumpData){
    for(var i= 0; i<pumpData.length; i++){
      if (pumpData[i].latitude && pumpData[i].longitude){
        var pump = new Pump(pumpData[i]);
        this.pumps.push(pump);
      }
    }
  },

  getProviderKioskData: function(){

  },

  getProviderPumpData: function(){

  }
};

//   parseJsonHubData: function(jsonData){
//     for (var i= 0; i<jsonData.length; i++){
//       var hubJsonData = jsonData[i];
//       if (hubJsonData.latitude && hubJsonData.longitude){
//         var hub = new Hub(hubJsonData);
//         this.hubs.push(hub);
//       }
//     }
//   },
// };


//Driver Test Code

testData = {id:"2", name:"Roger Moooore", created_at:"10/20/2014", town:"Kibera", postalCode:"93420", province:"Eastern", country:"Kenya", longitude:36.838866, latitude:-1.282470, waterPrice:2.02, status:"ok", errors:""}

testData1 = {id:"1", name:"Sean COOONery", created_at:"10/3/2014", town:"Kibera", postalCode:"93420", province:"Eastern", country:"Kenya", longitude:36.812044, latitude:-1.282942, waterPrice:8.02, status:"not ok", errors:"Door left open"}
