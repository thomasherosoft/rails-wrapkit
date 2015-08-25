$('body.marketing.index').ready ->
  $('[data-behavior="new-marketing-document"]').click ->
    # nothing yet

$('body.marketing.products').ready ->
  $('.table tr[data-href]').each ->
    $(this).css('cursor', 'pointer').hover((->
      $(this).addClass 'active'
    ), ->
      $(this).removeClass 'active'
    ).click ->
      $('.table tr[data-href]').removeClass 'selected'
      $(this).addClass 'selected'