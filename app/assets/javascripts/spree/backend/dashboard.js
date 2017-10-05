var DashboardChart = function (data, div_id) {
  this.data = data
  this.div_id = div_id

  this.multiBarHorizontalChart = function () {
    nv.addGraph(function() {
          var chart = nv.models.multiBarHorizontalChart()
          chart.x(function(d) { return d.label })
          chart.y(function(d) { return d.value })
          chart.showLegend(false)
          chart.showControls(false)
          chart.margin({top: 30, right: 20, bottom: 50, left: 175})
          chart.yAxis.tickFormat(d3.format('d'))
          d3.select('#' + this.div_id + ' svg')
              .datum(this.data)
              .call(chart)

          nv.utils.windowResize(chart.update)

          return chart
      })
  }

  this.discreteBarChart = function () {
    nv.addGraph(function() {
          var chart = nv.models.discreteBarChart()
          chart.x(function(d) { return d.label })
          chart.y(function(d) { return d.value })
          chart.showLegend(false)
          chart.margin({top: 30, right: 20, bottom: 50, left: 175})
          chart.yAxis.tickFormat(d3.format('d'))
          d3.select('#' + this.div_id + ' svg')
              .datum(this.data)
              .call(chart)

          nv.utils.windowResize(chart.update)

          return chart
      });

  }
}
