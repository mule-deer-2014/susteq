
var CGraphs = {
  $creditsSoldByKiosk: $("#credits-sold-by-kiosk")
}

HubChart.ChartMaker = function() {
  this.kioskDiv = document.getElementById("kiosk-charts");
  this.pumpDiv = document.getElementById("pump-charts");
  this.kioskData = [];
  this.pumpData = [];
}

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
  },

  get_credits_sold_by_kiosk: function(){
    var controller = this;
    if (CGraphs.$creditsSoldByKiosk.length > 0){
      var creditsKiosksAjax = $.get("/transactions/credits_sold_by_kiosk.json")
                                .done(function(data){

                                  new controller.BarChartMaker(data)
                                })
    }
  }
}

HubChart.BarChartMaker = function(object) {
  this.dataSet = object.dataSet;
  this.dom = object.dom;
}

HubChart.BarChartMaker.prototype = {
    prepareData:function(){
      //{location_id:#, amount:#}
      // var xAxis = [];
      // var yAxis = [];
      // for(var i=0; i<this.dataSet.length; i++){
      //   var hub = HubFunctions.findKioskById(this.dataSet[i].location_id);
      //   xAxis.push(hub.name);
      //   yAxis.push(this.dataSet[i].amount);
      // }
      var data = this.dataSet.slice()
      var idFn = function(d) { return d.location_id}
      var amountFn = function(d) { return d.amount }
    },

    createBarChart:function(){
      var margin = {top: 20, right: 30, bottom: 30, left: 40},
        width = 720 - margin.left - margin.right,
        height = 333 - margin.top - margin.bottom;
        // barWidth = width / data.length;

      var y = d3.scale.linear()
          .domain(d3.extent(data, amountFn))
          .range([height,0]);

      var x = d3.scale.ordinal()
          .domain(d3.extent(data, idFn))
          .rangeRoundBands([0, width]);

      // var z = d3.scale.linear()
      //     .domain([0, d3.max(data)])
      //     .range([height, 0]);

      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom");

      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left");


      var chart = d3.select(".chart")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      chart.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);

      chart.append("g")
          .attr("class", "y axis")
          .call(yAxis)
        .append("text")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", ".71em")
          .style("text-anchor", "end")
          .style("color", "black")
          .text("FUCKIN A RIGHT");

      var g = chart.selectAll(".placeholder-bar")
          .data(data)
        .enter().append("g")
          .attr("class", ".placeholder-bar");

      var bar = g.append("rect")
          .attr("class", "bar")
          .attr("x", function(d, i) { return (i * width/data.length)  })
          .attr("y", function(d) { return y(d) })
          .attr("height", function(d) { return height - y(d); })
          .attr("width", x.rangeBand() )
          .on({"mouseover": makeRed, "mouseout":makeBlue});


      // bar.append("rect")
      // bar is not a g element, it is a rect element which cannot contain text
      g.append("text")
          .attr("x", function(d, i) { return i * width/data.length })
          .attr("y", function(d) { return y(d) + 3; })
          .attr("dx", "5.5em")
          .attr("dy", "0.75em")
          .text(function(d) { return d; });



      function callBack(d, i){
          d3.select(bar[0][i]).style("fill", "green")
          d3.select(".text-box").attr("fill", "blue")
          d3.select(d3.select(this).node().parentNode.children[0]).style("fill", "green")
          debugger
      };

      function makeRed(d, i){
          d3.select(bar[0][i]).style("fill", "red");


          d3.select(g[0][i]).append("text").attr("class", "text-box")
              .attr("x", d3.select(g[0][i]).selectAll("rect").attr("x") )
              .attr("y", d3.select(g[0][i]).selectAll("rect").attr("y") )
              .attr("dx", "5.5em")
              .attr("dy", "-0.75em")
              .html("hey")
              .on("click", callBack)
              .transition()
              .duration(10000)
              .remove();
      };

      function makeBlue(d, i){
          d3.select(bar[0][i]).style("fill", "steelblue");
      };
    }
}
