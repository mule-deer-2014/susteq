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

var data = JSONData.slice()
console.log(data)
var amountFn = function(d) { return d.amount }
var idFn = function(d) { return d.location_id }

var margin = {top: 20, right: 30, bottom: 30, left: 60},
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


var chart = d3.select(".chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
  .append("text")
    .attr("x", width/2)
    .attr("y", 30)
    .style("font-size", 20)
    .text("kiosks");

chart.append("g")
    .attr("class", "y axis")
    .call(yAxis)
  .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("font-size", 20)
    .style("text-anchor", "end")
    .attr("fill", "black")
    .text("Credits sold");

var g = chart.selectAll(".placeholder-bar")
    .data(data)
  .enter().append("g")
    .attr("class", ".placeholder-bar")

var bar = g.append("rect")
    .attr("class", "bar")
    .attr("x", function(d, i) { return (i * width/JSONData.length)  })
    .attr("y", function(d) { return y(amountFn(d)) })
    .attr("height", function(d) { return height - y(amountFn(d)); })
    .attr("width", width/JSONData.length )
    .attr('fill', 'steelblue')
    .on({"mouseover": makeRed, "mouseout":makeBlue});


var offset = function(d, i) { return (i * width/JSONData.length) + width/JSONData.length / 2 }
// bar.append("rect")
// bar is not a g element, it is a rect element which cannot contain text
g.append("text")
    .attr("x", offset)
    .attr("y", function(d) { return y(amountFn(d)) + 3; })
    // .attr("dx", offset +"em")
    .attr("dy", "0.75em")
    .attr("text-anchor", "middle")
    .text(function(d) { return amountFn(d); });



function callBack(d, i){
    d3.select(".text-box").attr("fill", "blue")
    d3.select(d3.select(this).node().parentNode.children[0]).style("fill", "green")
    debugger
}

function makeRed(d, i){
    d3.select(bar[0][i]).style("fill", "red");
    debugger


    d3.select(g[0][i]).append("text").attr("class", "text-box")
        .attr("x", d3.select(g[0][i]).select("text").attr("x") )
        .attr("y", d3.select(g[0][i]).select("rect").attr("y") )
        // .attr("dx", "5.5em")
        .attr("dy", "-0.75em")
        .html("hey")
        .on("click", callBack)
        .transition()
        .duration(10000)
        .remove();

// A rect can't contain a text element. Instead transform a g element with the location of text and rectangle, then append both the rectangle and the text to it:
}

function makeBlue(d, i){
    d3.select(bar[0][i]).style("fill", "steelblue");


}
