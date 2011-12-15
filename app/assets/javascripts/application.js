// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $('#new_comment')
    .bind('ajax:beforeSend', function () {
    })

    .bind('ajax:complete', function() {
    })

    .bind('ajax:success', function(evt, data, status, xhr) {
      try {
        comment = $.parseJSON(xhr.responseText);
      } catch(err) {
        errors = {message: "Пожалуйста перезагрузите страницу и попробуйте еще раз"};
      }
      date = comment.created_at;
      $('div.comments').append("<div class='comment'>" + comment.body + "<div id='created_at'>" + dateFormat(date, "UTC:yyyy.mm.dd | HH:MM") + "</div></div>").children(':last').hide().fadeIn(2000);
      $(this).find('input:text,textarea').val('');
    })

    .bind('ajax:error',  function(evt, xhr, status, error) {
      try {
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        errors = {message: "Пожалуйста перезагрузите страницу и попробуйте еще раз"};
      }
      errorText = "Были допущены следующие ошибки: \n<ul>";
      for (error in errors) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li>";
      }
      errorText += "</ul>";

      alert(errorText);
  });

  $('a.add_attachment').click(function() {
    //alert('click');    
    var new_id = new Date().getTime();
    var input = "<div class='attachment' id='a_" + new_id + "'><input type='file' name='attachment[" + new_id + "]'><a class='remove_attachment'>удалить</a></div>";
    $('div.attachments').append(input);
  });

  $('a.remove_attachment').live('click',function() {
    $(this).parent().fadeOut('slow');
    $(this).parent().remove();      
  });  

});