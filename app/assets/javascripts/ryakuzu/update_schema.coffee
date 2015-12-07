$ ->
  $('#loading').hide()

  $(document).on 'ajaxStart', ->
    $('#loading').show()
    $('body').addClass('dark')

  $(document).on 'ajaxStop', ->
    $('#loading').hide()
    $('body').removeClass('dark')
