class Main
  constructor: ->
    # @data_table_syles()

  data_table_syles: ->
    # adding custom styles to all .datatables
    $('.datatables').each( ->
      datatables = $( this )
      # SEARCH - Add the placeholder for Search and Turn this into in-line form control
      searchInput = datatables.closest('.dataTables_wrapper').find('div[id$=_filter] input')
      searchInput.attr('placeholder', 'Search')
      searchInput.addClass 'form-control input-sm'
      # LENGTH - Inline-Form control
      lengthSel = datatables.closest('.dataTables_wrapper').find('div[id$=_length] select')
      lengthSel.addClass('form-control input-sm')
      # lengthSel.wrap( '<label class="select select-sm"></label>' )
      # Paginations
      paginations = datatables.closest( '.dataTables_wrapper' ).find( '.dataTables_paginate' ).children( '.pagination' )
      paginations.addClass 'pagination-sm'
    ).on 'draw.dt', ->
      $('.sidebar').wrapkitSidebar 'updateHeight'
  dialog: ->
    alert('test')

jQuery ->
  @main = Main.new