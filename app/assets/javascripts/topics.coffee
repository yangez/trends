# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", ->

  # Table on #index
  $table = $("[data-sort=table]")
  if $table.length && !$("#tableSorterPager1").length
    $table.tablesorter
      sortList: [[4, 1]]
      cssDesc: 'headerSortUp'
      cssAsc: 'headerSortDown'
      initialized: ->
        $table.show()
    .appendTablesorterPagerControls
      controlsOutput: '{first}{prev}{display}{next}{last}'
      output: '<strong>{startRow}-{endRow}</strong> / {totalRows}'

  # Chart on #show
  $chart = $('#historical-chart')
  if $chart.length
    myChart = new Chart($chart,
      type: 'line'
      data:
        labels: $chart.data('labels')
        datasets: [ {
          label: 'Activity Ratio (%)'
          data: $chart.data('points')
          backgroundColor: [
            'rgba(153, 102, 255, 0.2)'
            'rgba(255, 99, 132, 0.2)'
            'rgba(54, 162, 235, 0.2)'
            'rgba(255, 206, 86, 0.2)'
            'rgba(75, 192, 192, 0.2)'
            'rgba(255, 159, 64, 0.2)'
          ]
          borderColor: [
            'rgba(153, 102, 255, 1)'
            'rgba(255,99,132,1)'
            'rgba(54, 162, 235, 1)'
            'rgba(255, 206, 86, 1)'
            'rgba(75, 192, 192, 1)'
            'rgba(255, 159, 64, 1)'
          ]
          borderWidth: 1
        } ]
      options:
        legend: display: false
        scales: yAxes: [ { ticks: beginAtZero: true } ])
