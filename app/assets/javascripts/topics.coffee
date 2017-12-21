# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", ->
  if $("[data-sort=table]").length
    $("[data-sort=table]").tablesorter
      sortList: [[4, 1]]
      cssDesc: 'headerSortUp'
      cssAsc: 'headerSortDown'
    .appendTablesorterPagerControls
      controlsOutput: '{first}{prev}{display}{next}{last}'
      output: '<strong>{startRow}-{endRow}</strong> / {totalRows}'
