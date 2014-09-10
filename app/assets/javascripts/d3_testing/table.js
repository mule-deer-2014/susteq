
var JSONData = [
        {location_id: 1, amount: 50, date: "04/21/2014"},
        {location_id: 2, amount: 50},
        {location_id: 3, amount: 50},
        {location_id: 4, amount: 50},
        {location_id: 6, amount: 70}
 ];

// var JSONData = [
//     {
//         "provider":"provider1",
//         "hubs":[
//             {
//                 "kiosk": "kiosk1",
//                 "amount":10000,

//             },
//             {
//                 "pump": "pump1",
//                 "amount":5000
//             }
//         ]
//     },
//     {
//         "provider":"provider2",
//         "hubs":[
//             {
//                 "kiosk": "kiosk2",
//                 "amount":10000
//             },
//             {
//                 "pump": "pump2",
//                 "amount":5000,
//                 "end-users":[
//                     {
//                         "unique rfid":10
//                     },
//                 ]
//             }
//         ]
//     },
//     {
//         "provider":"provider3",
//         "hubs":[
//             {
//                 "kiosk": "kiosk3",
//                 "amount":10000
//             },
//             {
//                 "pump": "pump3",
//                 "amount":5000
//             }
//         ]
//     }
// ];
d3.select("#table").selectAll("table")
    .data([JSONData])
  .enter().append("table")
    .call(recurse);

function recurse(sel) {
  // sel is a d3.selection of one or more empty tables
  sel.each(function(d) {
    // d is an array of objects
    var colnames,
        tds,
        table = d3.select(this);

    // obtain column names by gathering unique key names in all 1st level objects
    // following method emulates a set by using the keys of a d3.map()
    colnames = d                                                          // array of objects
        .reduce(function(p,c) { return p.concat(d3.keys(c)); }, [])       // array with all keynames
        .reduce(function(p,c) { return (p.set(c,0), p); }, d3.map())      // map with unique keynames as keys
        .keys();                                                          // array with unique keynames (arb. order)

    // colnames array is in arbitrary order
    // sort colnames here if required

    // create header row using standard 1D data join and enter()
    table.append("thead").append("tr").selectAll("th")
        .data(colnames)
      .enter().append("th")
        .text(function(d) { return d; });

    // create the table cells by using nested 2D data join and enter()
    // see also http://bost.ocks.org/mike/nest/
    tds = table.append("tbody").selectAll("tr")
        .data(d)                            // each row gets one object
      .enter().append("tr").selectAll("td")
        .data(function(d) {                 // each cell gets one value
          return colnames.map(function(k) { // for each colname (i.e. key) find the corresponding value
            return d[k] || "";              // use empty string if key doesn't exist for that object
          });
        })
      .enter().append("td");

    // cell contents depends on the data bound to the cell
    // fill with text if data is not an Array
    tds.filter(function(d) { return !(d instanceof Array); })
        .text(function(d) { return d; });
    // fill with a new table if data is an Array
    tds.filter(function(d) { return (d instanceof Array); })
        .append("table")
        .call(recurse);
  });
}
