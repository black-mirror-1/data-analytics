// @TODO: YOUR CODE HERE!
var svgWidth = 960;
var svgHeight = 500;

var margin = { top: 20, right: 40, bottom: 60, left: 50 };

var width = svgWidth - margin.left - margin.right;
var height = svgHeight - margin.top - margin.bottom;

// Create an SVG wrapper, append an SVG group that will hold our chart, and shift the latter by left and top margins.
var svg = d3
    .select('#scatter')
    .append('svg')
    .attr('height', svgHeight)
    .attr('width', svgWidth)

var chartGroup = svg.append('g')
            .attr("transform", `translate(${margin.left}, ${margin.top})`);

d3.csv('assets/data/data.csv').then(function(healthCareData) {
    // if (error) throw error;

    console.log(healthCareData);
    healthCareData.forEach(state => {
        console.log(state.healthcare)
        state.healthcare = parseFloat(state.healthcare);
        state.poverty = parseFloat(state.poverty);
     });

    // setup x 
    var xScale = d3.scaleLinear()
            .domain(d3.extent(healthCareData, d => d.healthcare))
            .range([0, width]);
    var xAxis = d3.axisBottom(xScale);
    // setup y
    var yScale = d3.scaleLinear()
            .domain([0, d3.max(healthCareData, d => d.poverty)])    
            .range([height, 0]); // value -> display
    var yAxis = d3.axisLeft(yScale);
    
    // Add x-axis
    chartGroup.append("g")
    .attr("transform", `translate(0, ${height})`)
    .call(xAxis);

    // Add y1-axis to the left side of the display
    chartGroup.append("g")
        .call(yAxis);

    chartGroup.selectAll('.stateCircle')
        .data(healthCareData)
        .enter()
        .append('circle')
        .classed('stateCircle', true)
        .attr('cx',d => xScale(d.healthcare))
        .attr('cy', d => height - yScale(d.poverty))
        .attr('r',"10")
        .append('text')
        .classed('stateText', true)
        .text(d => d.abbr)
        .attr('x','50%')
        .attr('y','50%')
});