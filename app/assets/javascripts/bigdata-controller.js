BigData.Controller = function(){
  this.kiosks = [];
  this.pumps = [];
};

BigData.prototype = {

  adminGetKioskData: function(){
    var kioskAjax = $.ajax({
      url:"/admin/kiosks.json",
      method:"get"
    }).
    done(function(data){
      this.parseJsonKioskData(data.kiosks);
    }.bind(this)).
    fail();
  },

  parseJsonKioskData: function(kioskData){
    for(var i= 0; i<kioskData.length; i++){
      var kiosk = new Kiosk(kioskData[i].hub);
      kiosk.parseTransactions(kioskData[i].transactions)
      this.kiosks.push(kiosk);
    }
  },

  adminGetPumpData: function(){
    var pumpAjax = $.ajax({
      url:"/admin/pumps.json",
      method:"get"
    }).
    done(function(data){
      this.parseJsonPumpData(data.kiosks);
    }.bind(this)).
    fail();
  },

  parseJsonPumpData: function(pumpData){
    for(var i= 0; i<pumpData.length; i++){
      var pump = new Pump(pumpData[i].hub);
      pump.parseTransactions(pumpData[i].transactions)
      this.pumps.push(pump);
    }
  },
}