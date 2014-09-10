var data = [1,4,65,6,78,45];

var margin = {top: 20, right: 30, bottom: 30, left: 40},
    width = 720 - margin.left - margin.right,
    height = 333 - margin.top - margin.bottom,
    barWidth = width / data.length;

var y = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([height,0]);

var x = d3.scale.ordinal()
    .domain(["A", "B", "C", "D", "E", "F"])
    .rangeRoundBands([0, width]);
        console.log(x.rangeBand())


var z = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([height, 0]);

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
    .attr("class", ".placeholder-bar")

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
}

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



    // textField.transition()
    //     .duration(20000)
    //     .style("opacity", .9);
    // d3.select("body").append("div").attr("class", "test")
    // textField.html("you")
    //     .style("left", d3.select(g[0][i]).selectAll("rect").attr("x") + "px" )
    //     .style("top", d3.select(g[0][i]).selectAll("rect").attr("y") + "px")
    //     .style("margin-left", "5.5em")
    //     .style("margin-top", "-1em");


        // .style("left", (d3.event.pageX) + "px")
        // .style("top", (d3.event.pageY - 28) + "px");



// A rect can't contain a text element. Instead transform a g element with the location of text and rectangle, then append both the rectangle and the text to it:
}

// var textField = d3.select("body").append("div")
//     .attr("class", "test")

function makeBlue(d, i){
    d3.select(bar[0][i]).style("fill", "steelblue");
    // textField.transition()
    //     .duration(200)
    //     .style("opacity", .9);
    // d3.select(".text-box").transition()
    //     .duration(3000)
    //     .remove();





}
