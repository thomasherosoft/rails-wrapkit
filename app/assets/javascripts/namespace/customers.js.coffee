# Agent Index Page
$('.customers.index').ready ->
  toogleMailingAddress = ->
    $('.mailing_address').toggle()

  $('#customer_use_service_address').on 'click', toogleMailingAddress

  $('.customer_details_update').submit ->
    form_button = $(this).find('.btn')
    form_button.attr('disabled','disabled')
    form_button.find('span').addClass('hidden')
    form_button.find('.fa-spin').removeClass('hidden')
    valuesToSubmit = $(this).serialize()
    $.ajax(
      type: 'POST'
      url: $(this).attr('action')
      data: valuesToSubmit
      dataType: 'JSON').success (json) ->
        form_button.removeAttr('disabled')
        form_button.find('span').removeClass('hidden')
        form_button.find('.fa-spin').addClass('hidden')
        toastr[json.status](json.message)
        return
    false

  $('.datepick').datepicker()