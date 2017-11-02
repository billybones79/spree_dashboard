var Chart = function(data, div_id) {
  this.data = data;
  this.div_id = div_id;

  this.discreteBarChart = function (rotate, margins) {
    var that = this;
    nv.addGraph(function() {
      var chart = nv.models.discreteBarChart().staggerLabels(true);
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

  this.historicalBarGraph = function (margins) {
    var that = this
    nv.addGraph(function () {
        var user_data = that.data;
        user_data.map(function (series) {
            series.values = series.values.map(function (d) {
                return {x: d[0], y: d[1]};
            });
            return series;
        });
        var chart = nv.models.historicalBarChart();
        if (typeof margins !== 'undefined') {
          chart.margin({top: margins[0], right: margins[1], bottom: margins[2], left: margins[3]})
        }
        chart.xAxis.showMaxMin(true).tickFormat(function(d) {
            return d3.time.format('%d/%m/%y')(new Date(d));
        });
        chart.tooltip.keyFormatter(function(d) {
            return d3.time.format('%d/%m/%y')(new Date(d));
        });
        chart.useInteractiveGuideline(true);
        d3.select("#" + that.div_id + " svg").datum(user_data).transition().call(chart);
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

  this.lineBarGraph = function (margins) {
    var that = this
    nv.addGraph(function () {
        var chart;
        var data = that.data;
        data.map(function (series) {
            series.values = series.values.map(function (d) {
                return {x: d[0], y: d[1]}
            });
            return series;
        });
        var vals = data[0]['values'];
        var tickValues = [];
        if (vals) {
            for (var i=0; i<vals.length; i=i+2) {
                tickValues.push(vals[i].x);
            }
        }
        chart = nv.models.linePlusBarChart()
                .margin({top: 50, right: 80, bottom: 30, left: 80})
                .color(d3.scale.category10().range())
                .focusEnable(false);
        if (tickValues) {
            chart.xAxis.tickValues(tickValues);
        }
        chart.xAxis.tickFormat(function (d) {
            return d3.time.format('%b %y')(new Date(d));
        });
        chart.y2Axis.tickFormat(function (d) {
            return d3.format(',f')(d) + '$'
        });
        chart.x2Axis.tickFormat(function (d) {
            return d3.time.format('%b %y')(new Date(d));
        });
        chart.bars.forceY([0]).padData(false);
        if (typeof margins !== 'undefined') {
          chart.margin({top: margins[0], right: margins[1], bottom: margins[2], left: margins[3]})
        }
        d3.select('#' + that.div_id + ' svg')
                .datum(data)
                .transition().duration(500).call(chart);
        nv.utils.windowResize(chart.update);
        return chart;
    });
  }
}
