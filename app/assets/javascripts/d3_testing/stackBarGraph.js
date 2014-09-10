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
  { "date": "2014-01-01", "amount": 200, "location_id" : 01},
  { "date": "2014-01-01", "amount": 400, "location_id": 02  },
  { "date": "2014-01-01", "amount": 2500, "location_id":03  },
  { "date": "2014-01-01", "amount": 600, "location_id":04  },
  { "date": "2014-01-01", "amount": 78, "location_id": 05 },
  { "date": "2014-01-02", "amount": 100, "location_id":01  },
  { "date": "2014-01-02", "amount": 200, "location_id":02  },
  { "date": "2014-01-02", "amount": 400, "location_id":03  },
  { "date": "2014-01-02", "amount": 2500, "location_id":04  },
  { "date": "2014-01-02", "amount": 600, "location_id":05  },
  { "date": "2014-01-03", "amount": 100, "location_id":01  },
  { "date": "2014-01-03", "amount": 200, "location_id":02 },
  { "date": "2014-01-03", "amount": 400, "location_id":03  },
  { "date": "2014-01-03", "amount": 2500, "location_id":04  },
  { "date": "2014-01-03", "amount": 600, "location_id":05  },
  { "date": "2014-01-04", "amount": 100, "location_id":01 },
  { "date": "2014-01-04", "amount": 200, "location_id":02  },
  { "date": "2014-01-04", "amount": 400, "location_id":03  },
  { "date": "2014-01-04", "amount": 2500, "location_id":04 },
  { "date": "2014-01-04", "amount": 600, "location_id":05  },
  { "date": "2014-01-05", "amount": 78, "location_id": 01 },
  { "date": "2014-01-05", "amount": 100, "location_id":02  },
  { "date": "2014-01-05", "amount": 200, "location_id":03  },
  { "date": "2014-01-05", "amount": 400, "location_id":04  },
  { "date": "2014-01-05", "amount": 2500, "location_id" :05 },
  { "date": "2014-01-06", "amount": 600, "location_id":01  },
  { "date": "2014-01-06", "amount": 78, "location_id": 02 },
  { "date": "2014-01-06", "amount": 100, "location_id":03  },
  { "date": "2014-02-06", "amount": 200, "location_id": 04},
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
    .domain([0, d3.max(data, function(d) { return d.total; })])
    .range([height,0]);

var format = d3.time.format("%b %d");

var x = d3.scale.ordinal()
    .domain(data.map(function(d) { return format(new Date(d.date)); }))
    .rangeRoundBands([0, width]);


var colorChange = 360 / JSONData.length
var color = d3.scale.ordinal()
    // .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);
    .range(data.map(function(d, i) { return d3.hsl(i*colorChange, 1,.5); }))
    .domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));


// data.forEach(function(d) {
//   d.location_id = +d.location_id
//    // var y0 = 0;
//    // d.location_id = color.domain().map(function(name) { return {name: name, y0: y0, y1: y0 += +d[name]}; });
//    // d.amount = d.location_id[d.location_id.length - 1].y1;
//  });

data.forEach(function(d) {
   var y0 = 0;
   d.amount = color.domain().map(function(location_id, i) { return {location_id: location_id, y0: y0, y1: y0 += +d[location_id]}; });
   d.total = d.amount[d.amount.length - 1].y1;
 });

// SORTING FUNCTION!!
data.sort(function(a, b) { return b.date - a.date; })


// var z = d3.scale.linear()
//     .domain([0, d3.max(data)])
//     .range([height, 0]);
// d3.selectAll(".tick > text")
//   .style("font-size", function(d) { return d.date == 0 ? 32 : 24; });

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .innerTickSize([5])
    .tickPadding([3]);

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

//  CREATE CHART format
var chart = d3.select(".chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// d3.select(".chart").selectAll("text").style("font-size", 10).style("text-anchor", "middle");

var svgXAxis = chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
  .append("text")
    .attr("x", width/2)
    .attr("y", 25)
    .style("font-size", 20)
    .text("kiosks");

// d3.select(svgXAxis.node().parentNode).selectAll("text").style("font-size", 8).style("color", "black");
// d3.select(d3.select(svgXAxis.node().parentNode).selectAll("text")[0].pop()).style("font-size", 20)
// d3.select(svgXAxis.node().parentNode).selectAll("path").style("display", "none").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering: crispEdges");
// d3.select(svgXAxis.node().parentNode).selectAll("line").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering", "crispEdges");


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

// d3.select(svgYAxis.node().parentNode).selectAll("path").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering", "crispEdges");
// d3.select(svgYAxis.node().parentNode).selectAll("line").attr("fill", "none").attr("stroke", "#000").attr("shape-rendering", "crispEdges");


var g = chart.selectAll(".placeholder-bar")
    .data(data)
  .enter().append("g")
    .attr("class", ".placeholder-bar")

// Put BARS and DATA on CHART
var bar = g.append("rect")
    .attr("class", "bar")
    .attr("x", function(d, i) { return (i * width/JSONData.length)  })
    .attr("y", function(d) { return y(d.y1) })
    .attr("height", function(d) { return y(d.y0) - y(d.y1); })
    .attr("width", width/JSONData.length )
    .attr('fill', function(d) { return color(d.amount); })
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

var legend = svg.selectAll(".legend")
      .data(color.domain().slice().reverse())
    .enter().append("g")
      .attr("class", "legend")
      .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

  legend.append("rect")
      .attr("x", width - 18)
      .attr("width", 18)
      .attr("height", 18)
      .style("fill", color);

  legend.append("text")
      .attr("x", width - 24)
      .attr("y", 9)
      .attr("dy", ".35em")
      .style("text-anchor", "end")
      .text(function(d) { return d; });

