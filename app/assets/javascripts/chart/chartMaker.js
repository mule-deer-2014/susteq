HubChart.ChartMaker = function() {
  this.kioskDiv = document.getElementById("kiosk-charts");
  this.pumpDiv = document.getElementById("pump-charts");
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
    dates = [];
    amounts = [];
    for(var j=0; j<jsonDatum.transactions.length; j++) {
      dates.push(jsonDatum.transactions[j].transaction_time);
      amounts.push(jsonDatum.transactions[j].amount);
    }
    var dataSet = polyjs.data({
      date: dates,
      credits: amounts
    });
    this.kioskData.push(dataSet);
  },

  makePumpDatum: function(jsonDatum) {
    dates = [];
    amounts = [];
    for(var j=0; j<jsonDatum.transactions.length; j++) {
      dates.push(jsonDatum.transactions[j].transaction_time);
      amounts.push(jsonDatum.transactions[j].amount);
    }
    var dataSet = polyjs.data({
      date: dates,
      dispensed: amounts
    });
    this.pumpData.push(dataSet);
  },

  makeCharts: function() {
    var kLength = this.kioskData.length;
    var pLength = this.pumpData.length;
    if (kLength > 0) {
      for (var i=0; i<kLength; i++) {
        if ($("#kiosk-charts").length > 0) {
          var kioskGraph = document.createElement("div");
          this.kioskDiv.appendChild(kioskGraph);
          this.makeKioskChart(this.kioskData[i], kioskGraph);
        }
      }
    }
    if (pLength > 0) {
      for (var j=0; j<pLength; j++) {
        if ($("#pumps-charts").length > 0) {
          var pumpGraph = document.createElement("div");
          this.pumpDiv.appendChild(pumpGraph);
          this.makePumpChart(this.pumpData[j], pumpGraph);
        }
      }
    }
  },

  makeKioskChart: function(dataSet, chartElement) {
    polyjs.chart({
    layer: {
      data: dataSet,
      type: "bar",
      x: "bin(date, 'month')",
      y: "sum(credits)"
    },
    guide: {
      x: { title: "Month"},
      y: { title: ""}
    },
    title: "Credit Sales by Month",
    dom: chartElement,
    width: 500,
    height: 250
  });
  },

  makePumpChart: function(dataSet, chartElement) {
    polyjs.chart({
    layer: {
      data: dataSet,
      type: "bar",
      x: "bin(date, 'month')",
      y: "sum(dispensed)"
    },
    guide: {
      x: { title: "Month"},
      y: { title: ""}
    },
    title: "Liters of Water Dispensed by Month",
    dom: chartElement,
    width: 500,
    height: 250
  });
  }
};
