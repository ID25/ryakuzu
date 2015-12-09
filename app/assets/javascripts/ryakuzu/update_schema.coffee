$ ->
  $('#loading').hide()

  $(document).on 'ajaxStart', ->
    $('#loading').show()
    $('body').addClass('dark')

  $(document).on 'ajaxStop', ->
    $('#loading').hide()
    $('body').removeClass('dark')

  $('p#close-modal').on 'click', ->
    $('#modal1, #modal2, #modal3').closeModal()
    $('.lean-overlay').remove()
