// var JSONData = [
//   { "date": "2014-01-01", "rfid_id": 1},
//   { "date": "2014-01-01", "rfid_id": 2},
//   { "date": "2014-01-01", "rfid_id": 3},
//   { "date": "2014-01-01", "rfid_id": 4},
//   { "date": "2014-01-01", "rfid_id": 5},
//   { "date": "2014-01-02", "rfid_id": 1},
//   { "date": "2014-01-02", "rfid_id": 2},
//   { "date": "2014-01-02", "rfid_id": 3},
//   { "date": "2014-01-02", "rfid_id": 4},
//   { "date": "2014-01-03", "rfid_id": 7},
//   { "date": "2014-01-03", "rfid_id": 10},
//   { "date": "2014-01-03", "rfid_id": 12},
//   { "date": "2014-01-04", "rfid_id": 31},
//   { "date": "2014-01-04", "rfid_id": 2},
//   { "date": "2014-01-04", "rfid_id": 32},
//   { "date": "2014-01-04", "rfid_id": 45},
//   { "date": "2014-01-04", "rfid_id": 17},
//   { "date": "2014-01-04", "rfid_id": 18},
//   { "date": "2014-01-04", "rfid_id": 20},
//   { "date": "2014-01-04", "rfid_id": 21},
//   { "date": "2014-01-05", "rfid_id": 23},
//   { "date": "2014-01-05", "rfid_id": 24},
//   { "date": "2014-01-05", "rfid_id": 25},
//   { "date": "2014-01-05", "rfid_id": 2},
//   { "date": "2014-01-05", "rfid_id": 43},
//   { "date": "2014-01-06", "rfid_id": 34},
//   { "date": "2014-01-07", "rfid_id": 16},
//   { "date": "2014-01-08", "rfid_id": 18},
//   { "date": "2014-01-09", "rfid_id": 32},
//   { "date": "2014-01-09", "rfid_id": 14},
//   { "date": "2014-02-09", "rfid_id": 21},
// ];

var JSONData = [
  { "date": "2014-01-01", "amount": 20},
  { "date": "2014-01-02", "amount": 40},
  { "date": "2014-01-03", "amount": 20},
  { "date": "2014-01-04", "amount": 60},
  { "date": "2014-01-05", "amount": 78},
  { "date": "2014-01-06", "amount": 10},
  { "date": "2014-01-07", "amount": 20},
  { "date": "2014-01-08", "amount": 40},
  { "date": "2014-01-09", "amount": 20},
  { "date": "2014-01-10", "amount": 60},
  { "date": "2014-01-11", "amount": 70},
  { "date": "2014-01-12", "amount": 10},
  { "date": "2014-01-13", "amount": 20},
  { "date": "2014-01-14", "amount": 40},
  { "date": "2014-01-15", "amount": 25},
  { "date": "2014-01-16", "amount": 60},
  { "date": "2014-01-17", "amount": 78},
  { "date": "2014-01-18", "amount": 10},
  { "date": "2014-01-19", "amount": 20},
  { "date": "2014-01-20", "amount": 40},
  { "date": "2014-01-21", "amount": 20},
  { "date": "2014-01-22", "amount": 60},
  { "date": "2014-01-23", "amount": 78},
  { "date": "2014-01-24", "amount": 10},
  { "date": "2014-01-25", "amount": 20},
  { "date": "2014-01-26", "amount": 40},
  { "date": "2014-01-27", "amount": 25},
  { "date": "2014-01-28", "amount": 60},
  { "date": "2014-01-29", "amount": 78},
  { "date": "2014-01-30", "amount": 10},
  { "date": "2014-02-01", "amount": 20},
];

var data = JSONData.slice()
var amountFn = function(d) { return d.amount }


var margin = {top: 20, right: 20, bottom: 50, left: 60},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

    var parseDate = d3.time.format("%Y-%m-%d").parse;

    var x = d3.time.scale()
        .range([0, width]);

    var y = d3.scale.linear()
        .range([height, 0]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

var line = d3.svg.line()
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.amount); });

var chart = d3.select(".chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .on({"mousemove": lineDraw})
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

data.forEach(function(d) {
    d.date = parseDate(d.date);
    d.amount = +d.amount;
  });

  x.domain(d3.extent(data, function(d) { return d.date; }));
  y.domain([0, d3.max(data, amountFn)]);

  chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)
    .append("text")
      .attr("x", width/2)
      .attr("y", 35)
      .style("font-size", 20)
      .text("Date");

  chart.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Unique Kiosk Users");

  chart.append("path")
      .datum(data)
      .attr("class", "line")
      // .attr("stroke", function(d) {
      // var color = height - amountFn
      // debugger
      //     return "rgb(0, 0, " + color.toFixed(0) + ")";
      //    })
      .attr("d", line);


function lineDraw(d, i){
  // debugger
  var xMouse = d3.mouse(this)[0]
  var yMouse = d3.mouse(this)[1]
  d3.select(".hover-line").remove();
  d3.select(".hover-text").remove()

  d3.select(".chart").append("line")
        .attr("class", "hover-line")
        .attr("x1", width + margin.left )
        .attr("y1", yMouse - 5)
        .attr("x2", "0")
        .attr("y2",  yMouse - 5)
        .style("stroke-width", 2)
        .style("stroke", "grey")


  d3.select(".chart").append("text")
          .attr("class", "hover-text")
        .attr("x", xMouse - 5)
        .attr("y", yMouse - 5)
        .attr("fill", "black")
        .text(function(d) { return (5+d3.max(data, amountFn) - d3.mouse(this)[1]/height * d3.max(data, amountFn)).toFixed(0) + " Unique Users"; })


}



