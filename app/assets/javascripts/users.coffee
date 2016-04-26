# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@delete_input = (input) ->
  $(input).parent('.ui.action.input').parent('.field').remove()
  #$('#phone_numbers.field').remove()
  #$(input).remove()

ready = () ->
  $('.message .close').on 'click', ->
    $(this).closest('.message').transition 'fade'

  $('.ui.dropdown').dropdown()

  $('.ui.image').dimmer({
      on: 'hover'
  })
  $('.pup').popup()

  $('.add').unbind('click').click ->
    input_text = '<div class="field"><div class="ui mini action input"><input type="text" id="user_phones_list" name="user[phones_list][]"><a href="#" class="ui teal right icon button" data-content="Eliminar este campo" onclick="delete_input(this)"><i class="delete icon"></i></a></div></div>'
    $('#phone_numbers').append(input_text)

$(document).on('ready', ready)
$(window).bind('page:change', ready)