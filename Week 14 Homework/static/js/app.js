// from data.js
var tableData = data;

// YOUR CODE HERE!
d3.select('#filter-btn').on('click', function() {
    // Prevent the page from refreshing
    d3.event.preventDefault();
    var datetime = d3.select('#datetime').property('value');
    //validate
    // if(datetime === '') {
    //     d3.select('#filters').;
    // }
    var tableBody = d3.select('#ufo-table').select('tbody');
    data.forEach(d => {
        if(d['datetime'] === datetime) {
            var row = tableBody.append('tr');
            Object.entries(d).forEach(([key,value]) => {
                row.append('td').text(value)
            });
        }
    });
});
