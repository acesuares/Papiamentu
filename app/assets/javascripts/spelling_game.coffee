# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

delay = (time, fn, args...) ->
  setTimeout fn, time, args...

show_word = (word) ->
  $('#spelling_picture').attr('src', word['picture'])
  $('#spelling_audio').attr('src', word['recording'])
  $('#id').attr('value', word['id'])
  $('#spelling_audio').trigger("play")
  $('#answer').val('')
  $('#answer').focus()


$('#answer').keypress (e) ->
  if e.which == 13
    $.ajax
      type: 'POST'
      url: '/spelling/check'
      dataType: 'JSON'
      json: true
      data: "id=" + $('#id').val() + "&answer=" + $('#answer').val() + "&session_id=" + $('#session_id').val()
      success: (data, textStatus, jqXHR) ->
        if data['check'] == 'good'
          $('#myModal').find('#message').html('<i class="fi-check large"></i> korekto!')
          $('#myModal').find('#points').html('<i class="fi-plus"></i> 5')
          $('#myModal').foundation('reveal', 'open')
          delay 2000, ->
            $('#myModal').foundation('reveal', 'close')
            if data['next_word'] != ''
              show_word data['next_word']
            else
              location.href = "session_results?session_id=" + $('#session_id').val()
        else
          $('#myModal').find('#message').html('<i class="fi-x large"></i> sigui purba!')
          $('#myModal').find('#points').html('<i class="fi-minus"></i> 5')
          $('#myModal').foundation('reveal', 'open')
          delay 2000, ->
            $('#myModal').foundation('reveal', 'close')
            $('#answer').click()
            $('#spelling_audio').trigger("play")
            $('#answer').val('')
            $('#answer').focus()
      error: ->
        alert "Something went wrong"

ready = ->
  $('#spelling_audio').trigger("play");
  $('#answer').focus();

$(document).ready ready
