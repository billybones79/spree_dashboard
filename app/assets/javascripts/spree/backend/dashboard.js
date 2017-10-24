var Chart = function(data, div_id) {
  this.data = data;
  this.div_id = div_id;

  this.discreteBarChart = function (rotate, margins) {
    var that = this;
    nv.addGraph(function() {
      var chart = nv.models.discreteBarChart();
      chart.x(function(d) { return d.label });
      chart.y(function(d) { return d.value });
      chart.yAxis.tickFormat(d3.format('d'));
      if (typeof rotate === 'undefined') { rotate = false; }
      if (rotate) {
        chart.xAxis.rotateLabels(-90);
      }
      if (typeof margins !== 'undefined') {
        chart.margin({top: margins[0], right: margins[1], bottom: margins[2], left: margins[3]})
      }
      d3.select('#' + that.div_id + ' svg').datum(that.data).call(chart);
      nv.utils.windowResize(chart.update);

      return chart;
    });
  }
  this.multiBarHorizontalChart = function (margins) {
    var that = this;
    nv.addGraph(function() {
      var chart = nv.models.multiBarHorizontalChart();
      chart.x(function(d) { return d.label });
      chart.y(function(d) { return d.value });
      chart.yAxis.tickFormat(d3.format('d'));
      if (typeof margins !== 'undefined') {
        chart.margin({top: margins[0], right: margins[1], bottom: margins[2], left: margins[3]})
      }
      chart.showLegend(false);
      chart.showControls(false);
      d3.select('#' + that.div_id + ' svg').datum(that.data).call(chart);

      nv.utils.windowResize(chart.update);

      return chart;
    });
  }
  this.multiBarChart = function (margins) {
    var that = this;
    nv.addGraph(function() {
      var chart = nv.models.multiBarChart().showControls(false);
      if (typeof margins !== 'undefined') {
        chart.margin({top: margins[0], right: margins[1], bottom: margins[2], left: margins[3]})
      }
      d3.select('#' + that.div_id + ' svg').datum(that.data).call(chart);
      nv.utils.windowResize(chart.update);
      return chart;
    });
  }
  this.pieChart = function (margins) {
    var that = this;
    nv.addGraph(function() {
      var chart = nv.models.pieChart();
      chart.x(function(d) { return d.label });
      chart.y(function(d) { return d.value });
      chart.showLabels(true);
      chart.labelsOutside(true);
      if (typeof margins !== 'undefined') {
        chart.margin({top: margins[0], right: margins[1], bottom: margins[2], left: margins[3]});
      }
      d3.select("#"+ that.div_id +" svg").datum(that.data).transition().duration(350).call(chart);
      return chart;
    });
  }
}
