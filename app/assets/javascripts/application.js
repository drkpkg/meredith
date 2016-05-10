// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require photoswipe
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require_tree .

$(document).on('ready page:load', function() {
    $('.ui.dropdown').dropdown();
    $('.message .transition').on('click', function() {
        $(this).closest('.message').transition('fade');
    });
    $('.message.transition').on('click', function() {
        return $(this).closest('.message').transition('fade');
    });

    $('.ui.sticky').sticky();
    
    $('.menu .item').tab();

    $('.ui.dropdown').dropdown();

    $('.ui.accordion').accordion();

    $('.ui.image').dimmer({
        on: 'hover'
    });

    $('.profile').dimmer({
        on: 'hover'
    });

    $('.ui.modal').modal();

    $('.pup').popup();

    $('.add').unbind('click').click(function() {
        var input_text;
        input_text = '<div class="field"><div class="ui mini action input"><input type="text" id="user_phones_list" name="user[phones_list][]"><a href="#" class="ui teal right icon button" data-content="Eliminar este campo" onclick="delete_input(this)"><i class="delete icon"></i></a></div></div>';
        return $('#phone_numbers').append(input_text);
    });

    $('.sequenced .card').hover(
        function(){
            $(this).transition({
                debug     : false,
                animation : 'tada',
                duration  : 500,
                interval  : 200
            })
        }
    ).off( "mouseleave" );
});