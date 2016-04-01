$ ->
  $('#js-show-day').on('click', '.js-check-in', ->
    $checkbox    = $(this)
    checked      = $checkbox.prop('checked')
    url          = $checkbox.data('url')
    day          = $checkbox.data('day')
    data         = { checked: checked, day: day }
    success_icon = $checkbox.parents('td').find('.js-success')
    fail_icon    = $checkbox.parents('td').find('.js-fail')

    request = $.ajax(
      url: url,
      method: "PUT",
      data: data
    )

    request.done (data) ->
      success_icon.removeClass('hidden').hide().fadeIn().delay( 800 ).fadeOut()
    request.fail (data) ->
      fail_icon.removeClass('hidden').hide().fadeIn().delay( 800 ).fadeOut()
      $checkbox.prop('checked', !checked)
      alert ('There was an error saving your change. Please refresh the page and try again.\n\nError: ' + data.responseJSON.errors)
  )
