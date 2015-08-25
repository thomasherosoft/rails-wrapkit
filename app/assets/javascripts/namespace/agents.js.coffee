# Agent Index Page
$('.agents.index').ready ->
  agent_id = $('[data-behavior="employee-form"]')

  Dropzone.options.libraryDropzone =
    init: ->
      @on 'maxfilesexceeded', (file) ->
        @removeAllFiles()
        @addFile file
        return
      @on 'success', (file, responseText) ->
        $('.server_image').remove()
        toastr["success"]("Your image was updated")
        return
    maxFiles:1
    paramName: 'badge_image'
    previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n  <img data-dz-thumbnail />\n  </div>\n  <div class=\"dz-progress\"><span class=\"dz-upload\" data-dz-uploadprogress></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>"

  $('.agent_details_update').submit ->
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