HubChart.ChartMaker = function() {
  this.kioskData = [];
  this.pumpData = [];
};

HubChart.ChartMaker.prototype = {
  makeDataForHubs: function(jsonData) {
    for(var i=0; i<jsonData.length; i++) {
      if (jsonData[i].type !== "kiosk" && jsonData[i].type !== "pump") {
        console.log("Invalid JSON data: cannot chart this hub.");
      } else {
        jsonData[i].type === "kiosk" ?
          this.makeKioskDatum(jsonData[i]) :
          this.makePumpDatum(jsonData[i]);
      }
    }
  },

  makeKioskDatum: function(jsonDatum) {
    ret = [];
    dates = [];
    amounts = [];
    for(var j=0; j<jsonDatum.transactions.length; j++) {
      dates.push(jsonDatum.transactions[j].transaction_time);
      amounts.push(jsonDatum.transactions[j].amount);
    }
    ret.push(dates, amounts);
    this.kioskData.push(ret);
  },

  makePumpDatum: function(jsonDatum) {
    ret = [];
    dates = [];
    amounts = [];
    for(var j=0; j<jsonDatum.transactions.length; j++) {
      dates.push(jsonDatum.transactions[j].transaction_time);
      amounts.push(jsonDatum.transactions[j].amount);
    }
    ret.push(dates, amounts);
    this.pumpData.push(ret);
  }
};