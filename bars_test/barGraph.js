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

var bar = chart.selectAll(".bar")
    .data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("x", function(d, i) { return i * width/data.length })
    .attr("y", function(d) { return y(d); })
    .attr("height", function(d) { return height - y(d); })
    .attr("width", x.rangeBand());

// bar.append("rect")

bar.append("text")
    .attr("x", barWidth / 2)
    .attr("y", function(d) { return y(d) + 3; })
    .attr("dy", "0.75em")
    .text(function(d) { return d; });
