# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $("#progress").hide()
  $('#new_photo').fileupload
    dataType: 'script'
    progressall: (e, data) ->
      $("#progress").show()
      progress = parseInt((data.loaded / data.total) * 100, 10)
      $('#progress .meter').css('width', progress + '%').append(progress)

$(document).on('ready', ready)
$(window).bind('page:change', ready)