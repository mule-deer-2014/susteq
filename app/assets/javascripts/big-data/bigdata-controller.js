BigData.DataController = function(){
  this.kiosks = [];
  this.pumps = [];
  this.chartLibrary = [];
};

BigData.DataController.prototype = {

  generateMap: function(){
    if ($('#map').length > 0){
      var LAT_LONG_NAIROBI = [-1.283285, 36.821657];
      this.mapView = new HubMap.View(LAT_LONG_NAIROBI[0], LAT_LONG_NAIROBI[1], 11);
      this.mapView.displayAllHubs({kiosks:this.kiosks, pumps:this.pumps});
    }
  },

  getChartData: function(controllerMethodName, callbackFn ){
    var chartAjax = $.ajax({
      url:"/transactions" + controllerMethodName + ".json",
      method:"get",
      success:callbackFn,
      error:this.loadFailed
    })
  },

  // generateAdminCharts:function(){
  //   $.each(ChartLibrary, function(index, chartItem){
  //     if ($chartDiv.length > 0){
  //       this.getChartData(chartItem.controllerName, chartItem.callbackFn)
  //     }
  //   }
  // },

  checkPermissions: function(func){
    var permissionAjax = $.ajax({
      url:"/sessions.json",
      method:"get",
      success:(func)
    })
  },

  getAdminHubData: function(func){
    var pumpAjax = $.ajax({
      url:"/admin/pumps.json",
      method:"get",
      success:this.parseJsonPumpData.bind(this)
    });
    var kioskAjax = $.ajax({
      url:"/admin/kiosks.json",
      method:"get",
      success:this.parseJsonKioskData.bind(this)
    });
    $.when(pumpAjax, kioskAjax).done(func)
  },

  parseJsonKioskData: function(kioskData){
    for(var i= 0; i<kioskData.length; i++){
      var kiosk = new Kiosk(kioskData[i]);
      this.kiosks.push(kiosk);
    }
  },

  parseJsonPumpData: function(pumpData){
    for(var i= 0; i<pumpData.length; i++){
      var pump = new Pump(pumpData[i]);
      this.pumps.push(pump);
    }
  },

  getProviderHubData: function(func){
    var pumpAjax = $.ajax({
      url:"/pumps.json",
      method:"get",
      success:this.parseJsonPumpData.bind(this),
    });
    var kioskAjax = $.ajax({
      url:"/kiosks.json",
      method:"get",
      success:this.parseJsonKioskData.bind(this),

    });
    $.when(pumpAjax, kioskAjax).done(func)
  },
};

