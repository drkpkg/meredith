# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $("#progress").hide()
  $("#loading-message").hide()
  $('#new_photo').fileupload
    dataType: 'script'
    progressall: (e, data) ->
      $("#loading-message").show()
    stop: (e, data) ->
      $("#loading-message").hide();

$(document).on('ready', ready)
$(window).bind('page:change', ready)