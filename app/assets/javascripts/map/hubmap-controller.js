HubMap.Controller = function(view){
  this.view = view;
  this.kiosks = [];
  this.pumps = [];
};

HubMap.Controller.prototype = {

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

