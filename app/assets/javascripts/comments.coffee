# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  id = $("#tags").data("article-id")
  console.log "test----------#{id}"
  $("#tags").autocomplete
    source:  '/articles/' + id + '/autocomplete.json'
    minLength: 1
  # console.log "text----------#{$(this).val()}"
  # '<a href="...">' + $("#tags").val() + '/>'