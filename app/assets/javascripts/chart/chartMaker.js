HubChart.ChartMaker = function() {
  this.kioskData = [];
  this.pumpData = [];
};

HubChart.ChartMaker.prototype = {
  makeDataForHubs: function(jsonData) {
    if (jsonData.hasOwnProperty('kiosks') && jsonData.hasOwnProperty('pumps')) {
      this.makeKioskData(jsonData.kiosks);
      this.makePumpData(jsonData.pumps);
    } else if (jsonData.hasOwnProperty('kiosks')) {
      this.makeKioskData(jsonData.kiosks);
    } else if (jsonData.hasOwnProperty('pumps')) {
      this.makePumpData(jsonData.pumps);
    } else {
      console.log("Invalid JSON data: cannot chart these hubs.");
    }
  },

  makeKioskData: function(jsonData) {
    ret = [];
    dates = [];
    amounts = [];
    for(var i=0; i < jsonData.length; i++) {
      for(var j=0; j<jsonData[i].transactions.length; j++) {
        dates.push(jsonData[i].transactions[j].transaction_time);
        amounts.push(jsonData[i].transactions[j].amount);
      }
    }
    ret.push(dates, amounts);
    this.kioskData = ret;
  },

  makePumpData: function(jsonData) {
    ret = [];
    dates = [];
    amounts = [];
    for(var i=0; i < jsonData.length; i++) {
      for(var j=0; j<jsonData[i].transactions.length; j++) {
        dates.push(jsonData[i].transactions[j].transaction_time);
        amounts.push(jsonData[i].transactions[j].amount);
      }
    }
    ret.push(dates, amounts);
    this.pumpData = ret;
  }
};