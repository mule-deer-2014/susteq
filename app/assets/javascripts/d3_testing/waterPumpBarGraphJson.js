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
  { "location_id": 1, "amount": 2},
  { "location_id": 2, "amount": 4},
  { "location_id": 3, "amount": 65},
  { "location_id": 4, "amount": 6},
  { "location_id": 5, "amount": 99},
  { "location_id": 6, "amount": 100}
];

var data = JSONData.slice()
console.log(data)
var amountFn = function(d) { return d.amount }
var idFn = function(d) { return d.location_id }

var margin = {top: 20, right: 30, bottom: 30, left: 40},
    width = 720 - margin.left - margin.right,
    height = 333 - margin.top - margin.bottom;
    // barWidth = width / data.length;

var y = d3.scale.linear()
    .domain([0, d3.max(data, amountFn)])
    .range([height,0]);

var x = d3.scale.ordinal()
    .domain(data.map(function(d) { return d.location_id; }))
    .rangeRoundBands([0, width]);


// var z = d3.scale.linear()
//     .domain([0, d3.max(data)])
//     .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .ticks(10, "id");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

//  CREATE CHART format
var chart = d3.select(".chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .on({"mousemove": lineDraw})
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
  .append("text")
    .attr("x", width/2)
    .attr("y", 25)
    .style("font-size", 20)
    .text("kiosks");

chart.append("g")
    .attr("class", "y axis")
    .call(yAxis)
  .append("text")
    .attr("x", width/2)
    .attr("y", -10)
    .attr("dy", ".71em")
    .style("font-size", 20)
    .style("text-anchor", "end")
    .attr("fill", "black")
    .text("Credits sold");

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
    // .attr("fill", "steelblue")
    .attr("fill", function(d) {
      var color = height - y(amountFn(d))
          return "rgb(0, 0, " + color.toFixed(0) + ")";
         })
    .on({"mouseover": makeRed, "mouseout":makeBlue});

// d3.selectAll(g).attr("fill", function(d) {
//       var color = height - y(amountFn(d))
//           return "rgb(0, 0, " + color + ")";
//          })

var offset = function(d, i) { return (i * width/JSONData.length) + width/JSONData.length / 2 }
// bar.append("rect")
// bar is not a g element, it is a rect element which cannot contain text
g.append("text")
    .attr("x", offset)
    .attr("y", function(d) { return y(amountFn(d)) + 3; })
    .attr("dy", "0.75em")
    .text(function(d) { return amountFn(d); });

var sortOrder = false;

// EVENT FUNCTIONS
function callBack(d, i){
    d3.select(".text-box").attr("fill", "blue")
    d3.select(d3.select(this).node().parentNode.children[0]).style("fill", "green")
    // debugger
    sortOrder = !sortOrder;
// data.sort(function(a, b) { return b.amount - a.amount; })

        chart.selectAll("rect")
           .sort(function(a, b) {
              if (sortOrder) {
                return b.amount - a.amount;
              } else {
                // debugger
                return b.amount - a.amount;
              }
            })
           .transition()
           .delay(function(d, i) {
             return i * 50;
           })
           .duration(1000)
           .attr("x", function(d, i) {
              return (i * width/JSONData.length);
           });

}

function lineDraw(d, i){
  // debugger
  var xMouse = d3.mouse(this)[0]
  var yMouse = d3.mouse(this)[1]
  d3.select(".hover-line").remove();
  d3.select(".hover-text").remove()

  d3.select(".chart").append("line")
        .attr("class", "hover-line")
        .attr("x1", width +  margin.left)
        .attr("y1", yMouse -5)
        .attr("x2", "0")
        .attr("y2",  yMouse -5 )
        .style("stroke-width", 2)
        .style("stroke", "grey")




  d3.select(".chart").append("text")
          .attr("class", "hover-text")
        .attr("x", xMouse )
        .attr("y", yMouse -5)
        .attr("fill", "black")
        .text(function(d) { return (9+d3.max(data, amountFn)-yMouse/height *d3.max(data, amountFn)).toFixed(0) + " credits"; })


}

function makeRed(d, i){
    d3.select(bar[0][i]).style("fill", "red");
    // data.sort(function(a, b) { return b.amount - a.amount; })



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
    d3.select(".hover-line").remove();
    d3.select(".hover-text").remove()


}

