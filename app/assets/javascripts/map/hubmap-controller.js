//Initialize Map
//Take in data
//parse JSON data and initialize models
//Create markers
//Create popups
//set event listeners
//Render markers

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

  getAdminKioskData: function(){
    var kioskAjax = $.ajax({
      url:"/admin/kiosks",
      method:"get"
    }).
    done(function(data){
      debugger
      // this.parseJsonKioskData(data).bind(this);
      // this.view.renderMarkers(this.kiosks);
    }).
    fail();
  },

  getAdminPumpData: function(){

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
//         hub = new Hub(hubJsonData);
//         this.hubs.push(hub);
//       }
//     }
//   },
// };


//Driver Test Code

testData = {id:"2", name:"Roger Moooore", created_at:"10/20/2014", town:"Kibera", postalCode:"93420", province:"Eastern", country:"Kenya", longitude:36.838866, latitude:-1.282470, waterPrice:2.02, status:"ok", errors:""}

testData1 = {id:"1", name:"Sean COOONery", created_at:"10/3/2014", town:"Kibera", postalCode:"93420", province:"Eastern", country:"Kenya", longitude:36.812044, latitude:-1.282942, waterPrice:8.02, status:"not ok", errors:"Door left open"}
