BarChart.ChartMaker = function() {
  this.margin   = { top: 20, right: 30, bottom: 30, left: 60 };
  this.width    = 720 - this.margin.left - this.margin.right;
  this.height   = 333 - this.margin.top - this.margin.bottom;
  this.data = [];
};

BarChart.ChartMaker.prototype = {
  makeChart: function(chartOptions) {
    this.setData(chartOptions.dataSet);
    this.setScales();
    this.setAxes();
    this.drawChart(chartOptions.yAxisTitle, chartOptions.xAxisTitle);
  },

  getAmount: function(d) { return d.amount; },
  
  getId:     function(d) { return d.location_id; },

  setData:   function(jsonData) {
    this.data = jsonData.slice();
    this.dataLength = jsonData.length;
    this.barWidth = this.width / this.dataLength;
  },

  setScales: function() {
    this.setYScale();
    this.setXScale();
  },

  setAxes: function() {
    var that = this;
    this.setXAxis();
    this.setYAxis();
  },

  setYScale: function() {
    var that = this;
    this.y = d3.scale.linear()
               .domain([0, d3.max(that.data, that.getAmount)])
               .range([that.height,0]);
  },

  setXScale: function() {
    var that = this;
    this.x = d3.scale.ordinal()
    .domain(that.data.map(function(d) { return d.location_id; }))
    .rangeRoundBands([0, that.width]);
  },

  setXAxis: function() {
    var that = this;
    this.xAxis = d3.svg.axis()
    .scale(that.x)
    .orient("bottom")
    .ticks(that.dataLength, "id");
  },

  setYAxis: function() {
    var that = this;
    this.yAxis = d3.svg.axis()
    .scale(that.y)
    .orient("left");
  },

  drawChart: function(title, hubType) {
    var that = this;
    var chart = d3.select(".chart")
        .attr("width", that.width + that.margin.left + that.margin.right)
        .attr("height", that.height + that.margin.top + that.margin.bottom)
      .append("g")
        .attr("transform", "translate(" + that.margin.left + "," + that.margin.top + ")");
  
    chart.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + that.height + ")")
        .call(that.xAxis)
      .append("text")
        .attr("x", that.width/2)
        .attr("y", 30)
        .style("font-size", 20)
        .text(hubType);

    chart.append("g")
        .attr("class", "y axis")
        .call(that.yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("font-size", 20)
        .style("text-anchor", "end")
        .attr("fill", "black")
        .text(title);

    var g = chart.selectAll(".placeholder-bar")
        .data(that.data)
      .enter().append("g")
        .attr("class", ".placeholder-bar");

    var bar = g.append("rect")
        .attr("class", "bar")
        .attr("x", function(d, i) { return (i * that.width/that.dataLength); })
        .attr("y", function(d) { return that.y(that.getAmount(d)); })
        .attr("height", function(d) { return that.height - that.y(that.getAmount(d)); })
        .attr("width", that.width/that.dataLength)
        .attr('fill', 'steelblue')
        .on({"mouseover": highlightBar, "mouseout": makeBlue});

    var offset = function(d, i) {
        return (i * that.width/that.dataLength) + that.width/that.dataLength / 2;
    };

    g.append("text")
        .attr("x", offset)
        .attr("y", function(d) { return that.y(that.getAmount(d)) + 3; })
        .attr("dy", ".75em")
        .attr("text-anchor", "middle")
        .text(function(d) { return that.getAmount(d); });

    function highlightBar(d, i){
        d3.select(bar[0][i]).style("fill", "#59c");

        d3.select(g[0][i]).append("text").attr("class", "text-box")
            .attr("x", d3.select(g[0][i]).select("text").attr("x") )
            .attr("y", d3.select(g[0][i]).select("rect").attr("y") )
            .attr("dy", "-0.75em")
            .remove();
    }

    function makeBlue(d, i){
        d3.select(bar[0][i]).style("fill", "steelblue");
    }
  }
};

//=====================================================
//                    DRIVER CODE
//=====================================================

var JSONData = [
  { "location_id": 1, "amount": 25160},
  { "location_id": 2, "amount": 75760},
  { "location_id": 3, "amount": 1000},
  { "location_id": 4, "amount": 89520},
  { "location_id": 5, "amount": 24150},
  { "location_id": 6, "amount": 496580},
  { "location_id": 7, "amount": 300},
  { "location_id": 8, "amount": 89520},
  { "location_id": 9, "amount": 24150},
  { "location_id": 10, "amount": 496580},
  { "location_id": 13, "amount": 49650},
];

var b = new BarChart.ChartMaker();
b.makeChart({dataSet: JSONData, yAxisTitle: "Credits Sold", xAxisTitle: "Kiosk"});