# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

is_empty = ->
  $("#tags").val().replace(/\s/g, '').length == 0

find_at_sign = ->
  if $("#tags").val().split('').pop() == "@"
    console.log $("#tags").val().split('')
    id = $("#tags").data("article-id")
    $("#tags").autocomplete
      source:  '/articles/' + id + '/autocomplete.json'
      minLength: 1
      focus: (event) ->
        event.preventDefault()
      select: (event, ui) ->
        event.preventDefault()
        this.value = this.value.replace(/@(\w*)$/, "@" + ui.item.value)

$ ->
  $(document).on("input", "#tags",
  -> find_at_sign())

