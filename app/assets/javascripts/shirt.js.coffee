$ ->
  $('.js-shirt-table').on('switchChange.bootstrapSwitch', '.js-paid-shirt-switch', ->
    $checkbox    = $(this)
    volunteer_id = $checkbox.data('volunteer-id')
    checked      = $checkbox.prop('checked')
    url          = $checkbox.data('url')
    data         = { id: volunteer_id, paid: checked }
    success_icon = $checkbox.parents('td').find('.js-success')
    fail_icon    = $checkbox.parents('td').find('.js-fail')

    console.log data

    request = $.ajax(
      url: url,
      method: "POST",
      data: data
    )

    request.done (data) ->
      success_icon.removeClass('hidden').hide().fadeIn().delay( 800 ).fadeOut()
    request.fail (data) ->
      fail_icon.removeClass('hidden').hide().fadeIn().delay( 800 ).fadeOut()
      $checkbox.bootstrapSwitch('toggleState', 'skip')
      alert ('There was an error saving your change. Please refresh the page and try again.\n\nError: ' + data.responseJSON.errors)
  )