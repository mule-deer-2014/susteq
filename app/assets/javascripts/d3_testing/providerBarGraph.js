var svg = d3.select('body').append('svg')
    .attr('width', width)
    .attr('height', height);

var gradient = svg.append("svg:defs")
    .append("svg:linearGradient")
    .attr("id", "gradient")
    .attr("x1", "0%")
    .attr("y1", "0%")
    .attr("x2", "100%")
    .attr("y2", "100%")
    .attr("spreadMethod", "pad");

// Define the gradient colors
gradient.append("svg:stop")
    .attr("offset", "15%")
    .attr("stop-color", "#0099FF")
    .attr("stop-opacity", 1);

gradient.append("svg:stop")
    .attr("offset", "100%")
    .attr("stop-color", "#000099")
    .attr("stop-opacity", 1);


// DATA!!!

var JSONData = [
  { "date": "2014-01-01", "amount": 200},
  { "date": "2014-01-02", "amount": 400},
  { "date": "2014-01-03", "amount": 2500},
  { "date": "2014-01-04", "amount": 600},
  { "date": "2014-01-05", "amount": 78},
  { "date": "2014-01-06", "amount": 100},
  { "date": "2014-01-07", "amount": 200},
  { "date": "2014-01-08", "amount": 400},
  { "date": "2014-01-09", "amount": 2500},
  { "date": "2014-01-10", "amount": 600},
  { "date": "2014-01-11", "amount": 78},
  { "date": "2014-01-12", "amount": 100},
  { "date": "2014-01-13", "amount": 200},
  { "date": "2014-01-14", "amount": 400},
  { "date": "2014-01-15", "amount": 2500},
  { "date": "2014-01-16", "amount": 600},
  { "date": "2014-01-17", "amount": 78},
  { "date": "2014-01-18", "amount": 100},
  { "date": "2014-01-19", "amount": 200},
  { "date": "2014-01-20", "amount": 400},
  { "date": "2014-01-21", "amount": 2500},
  { "date": "2014-01-22", "amount": 600},
  { "date": "2014-01-23", "amount": 78},
  { "date": "2014-01-24", "amount": 100},
  { "date": "2014-01-25", "amount": 200},
  { "date": "2014-01-26", "amount": 400},
  { "date": "2014-01-27", "amount": 2500},
  { "date": "2014-01-28", "amount": 600},
  { "date": "2014-01-29", "amount": 78},
  { "date": "2014-01-30", "amount": 100},
  { "date": "2014-02-01", "amount": 200},
];

var data = JSONData.slice()
console.log(data)
// var format = d3.time.format("%Y %b %d ")
var amountFn = function(d) { return d.amount }
var idFn = function(d) { return d.date }

var margin = {top: 20, right: 30, bottom: 30, left: 40},
    width = 900 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;
    // barWidth = width / data.length;

var y = d3.scale.linear()
    .domain([0, d3.max(data, amountFn)])
    .range([height,0]);

var format = d3.time.format("%b %d");

var x = d3.scale.ordinal()
    .domain(data.map(function(d) { return format(new Date(d.date)); }))
    .rangeRoundBands([0, width]);


// var z = d3.scale.linear()
//     .domain([0, d3.max(data)])
//     .range([height, 0]);
// d3.selectAll(".tick > text")
//   .style("font-size", function(d) { return d.date == 0 ? 32 : 24; });

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .innerTickSize([5])
    .tickPadding([3])
    ;

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

//  CREATE CHART format
var chart = d3.select(".chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.select(".chart").selectAll("text").style("font-size", 10).style("text-anchor", "middle");

var svgXAxis = chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
  .append("text")
    .attr("x", width/2)
    .attr("y", 25)
    .style("font-size", 20)
    .text("kiosks");

d3.select(svgXAxis.node().parentNode).selectAll("text").style("font-size", 8).style("color", "black");
d3.select(d3.select(svgXAxis.node().parentNode).selectAll("text")[0].pop()).style("font-size", 20)
d3.select(svgXAxis.node().parentNode).selectAll("path").style("display", "none").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering: crispEdges");
d3.select(svgXAxis.node().parentNode).selectAll("line").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering", "crispEdges");
// d3.select(svgYAxis.node().parentNode).select("path").style("display", "none")


var svgYAxis = chart.append("g")
    .attr("class", "y axis")
    .call(yAxis)
  .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("font-size", 20)
    .style("text-anchor", "end")
    .attr("fill", "black")
    .text("Liters");

d3.select(svgYAxis.node().parentNode).selectAll("path").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering", "crispEdges");
d3.select(svgYAxis.node().parentNode).selectAll("line").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering", "crispEdges");


var g = chart.selectAll(".placeholder-bar")
    .data(data)
  .enter().append("g")
    .attr("class", ".placeholder-bar")

// Put BARS and DATA on CHART
var bar = g.append("rect")
    .attr("class", "bar")
    .attr("x", function(d, i) { return (i * width/JSONData.length)  })
    .attr("y", function(d) { return y(amountFn(d)) })
    .attr("height", function(d) { return height - y(amountFn(d)); })
    .attr("width", width/JSONData.length )
    .attr('fill', 'url(#gradient)')
    .on({"mouseover": makeRed, "mouseout":makeBlue});


var offset = function(d, i) { return (i * width/JSONData.length) + width/JSONData.length / 2 }
// bar.append("rect")
// bar is not a g element, it is a rect element which cannot contain text
g.append("text")
    .attr("x", offset)
    .attr("y", function(d) { return y(amountFn(d)) + 3; })
    .attr("dy", "0.75em")
    .text(function(d) { return amountFn(d); });


// EVENT FUNCTIONS
function callBack(d, i){
    d3.select(".text-box").attr("fill", "blue")
    d3.select(d3.select(this).node().parentNode.children[0]).style("fill", "green")
    debugger
}

function makeRed(d, i){
    d3.select(bar[0][i]).style("fill", "red");


    d3.select(g[0][i]).append("text").attr("class", "text-box")
        .attr("x", d3.select(g[0][i]).select("text").attr("x") )
        .attr("y", d3.select(g[0][i]).select("rect").attr("y") )
        .attr("dy", "-0.75em")
        .html("hey")
        .on("click", callBack)
        .transition()
        .duration(10000)
        .remove();

// A rect can't contain a text element. Instead transform a g element with the location of text and rectangle, then append both the rectangle and the text to it:
}

function makeBlue(d, i){
    d3.select(bar[0][i]).style("fill", 'url(#gradient)');


}

