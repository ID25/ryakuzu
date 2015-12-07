$ ->
  $('#loading').hide()

  $(document).on 'ajaxStart', ->
    $('#loading').show()

  $(document).on 'ajaxStop', ->
    $('#loading').hide()
