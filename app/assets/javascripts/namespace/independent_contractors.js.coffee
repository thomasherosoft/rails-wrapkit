$('.independent_contractors.index').ready ->
  search_by_role = ""
  aoData = []
  $('.search_by_role').children().on 'click', (e) ->
    search_by_role = $(this).text()
    table.dataTable().fnDraw()
    return
  table = $('table#independent-contractors').dataTable
    processing: false
    serverSide: true
    ajax:
      'url': $('table#independent-contractors').data('source')
      'data': (d) ->
        $.extend {}, d, 'extra_search': search_by_role
    'aoColumnDefs': [{
      'sClass': 'agent-number'
      'aTargets': [ 2 ]
    }]

  $('[data-behavior="add-ic"]').click ->
    dataSource = $(this).data('source')
    BootstrapDialog.show
      size: BootstrapDialog.SIZE_WIDE
      type: BootstrapDialog.TYPE_DEFAULT
      title: 'New Independent Contractor'
      message: $('<div></div>').load(dataSource)
