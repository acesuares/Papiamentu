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
  $("#answer").prop('disabled', false);
  $('#answer').val('')
  $('#answer').focus()

next_word = (current) ->
  $.ajax
    type: 'GET'
    url: '/spelling/siguiente'
    dataType: 'JSON'
    json: true
    data: "id=" + current
    success: (data, textStatus, jqXHR) ->
      if data['next_word'] != ''
        show_word data['next_word']
      else
        location.href = "session_results?session_id=" + $('#session_id').val()
    error: ->
      alert "Something went wrong"

$('#modal-good').find('#siguiente-button').click (e) ->
  $('#modal-good').foundation('reveal', 'close')
  next_word ''

$('#modal-wrong').find('#bon-button').click (e) ->
  $('#modal-wrong').foundation('reveal', 'close')
  $('#spelling_audio').trigger("play")
  $("#answer").prop('disabled', false);
  $('#answer').val('')
  $('#answer').focus()

$('#modal-after-2-tries').find('#ripiti-button').click (e) ->
  $('#modal-after-2-tries').foundation('reveal', 'close')
  $('#spelling_audio').trigger("play")
  $("#answer").prop('disabled', false);
  $('#answer').val('')
  $('#answer').focus()

$('#modal-after-2-tries').find('#siguiente-button').click (e) ->
  $('#modal-after-2-tries').foundation('reveal', 'close')
  next_word $('#id').val()


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
          $('#modal-good').foundation('reveal', 'open')
          $("#answer").prop('disabled', true);
        else
          if data['tries'] > 2
            $('#modal-after-2-tries').find('#correct-spelling').html(data['word_spelling'])
            $('#modal-after-2-tries').foundation('reveal', 'open')
            #delay 4000, ->
            #  $('#myModal').foundation('reveal', 'close')
            #  show_word data['next_word']
          else
            $('#modal-wrong').foundation('reveal', 'open')
            $("#answer").prop('disabled', true);
      error: ->
        alert "Something went wrong"

$('#check-button').click (e) ->
  e.preventDefault()
  $.ajax
    type: 'POST'
    url: '/spelling/check'
    dataType: 'JSON'
    json: true
    data: "id=" + $('#id').val() + "&answer=" + $('#answer').val() + "&session_id=" + $('#session_id').val()
    success: (data, textStatus, jqXHR) ->
      if data['check'] == 'good'
        $('#modal-good').foundation('reveal', 'open')
        $("#answer").prop('disabled', true);
      else
        if data['tries'] > 2
          $('#modal-after-2-tries').find('#correct-spelling').html(data['word_spelling'])
          $('#modal-after-2-tries').foundation('reveal', 'open')
          #delay 4000, ->
          #  $('#myModal').foundation('reveal', 'close')
          #  show_word data['next_word']
        else
          $('#modal-wrong').foundation('reveal', 'open')
          $("#answer").prop('disabled', true);
    error: ->
      alert "Something went wrong"

ready = ->
  $('#spelling_audio').trigger("play");
  $('#answer').focus();

$(document).ready ready
