# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", ->
  $table = $("[data-sort=table]")
  if $table.length
    $table.tablesorter
      sortList: [[4, 1]]
      cssDesc: 'headerSortUp'
      cssAsc: 'headerSortDown'
      initialized: ->
        $table.show()
    .appendTablesorterPagerControls
      controlsOutput: '{first}{prev}{display}{next}{last}'
      output: '<strong>{startRow}-{endRow}</strong> / {totalRows}'
