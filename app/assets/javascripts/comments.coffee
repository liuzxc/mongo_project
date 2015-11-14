# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

is_empty = ->
  $("#tags").val().replace(/\s/g, '').length == 0

$ ->
  $(document).on("input", "#tags", ->
    content = $("#tags").val()
    if content[content.length - 1] == "@"
      id = $("#tags").data("article-id")
      $("#tags").autocomplete
        source:  '/articles/' + id + '/autocomplete.json'
        minLength: 1
        focus: (event) -> # event在焦点被移动到条目中时被触发，默认的行为是用列表栏中聚焦项目的值取代文本框中的值
          event.preventDefault() #阻止默认的行为被触发
        select: (event, ui) ->   #event在列表中的条目被选中时触发，默认的行为是用列表栏中选中项目的值取代文本框中的值
          event.preventDefault()
          this.value = this.value.replace(/@(\w*)$/, "@" + ui.item.value))

