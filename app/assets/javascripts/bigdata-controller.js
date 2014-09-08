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
      this.view.renderMarkers(this.kiosks);
    }.bind(this)).
    fail();
  },

  parseJsonKioskData: function(kioskData){
    for(var i= 0; i<kioskData.length; i++){
      var kiosk = new Kiosk(kioskData[i]);
      this.kiosks.push(kiosk);
    }
  },

}