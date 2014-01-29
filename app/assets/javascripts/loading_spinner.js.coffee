@PageSpinner =
  spin: (ms=500)->
    @spinner = setTimeout( (=> @add_spinner()), ms)
    $(document).on 'page:change', =>
      @remove_spinner()
  spinner_html: '
    <div class="modal hide fade" id="page-spinner">
      <div class="modal-header">
        <h3>Please Wait</h3>
        </div>
      <div class="modal-body card-body">
        <div class="progress progress-striped active">
          <div class="bar" style="width: 100%;"></div>
        </div>
        <p>We\'re loading your request</p>
      </div>
    </div>
  '
  spinner: null
  add_spinner: ->
    $('body').append(@spinner_html)
    $('body div#page-spinner').modal()
  remove_spinner: ->
    clearTimeout(@spinner)
    $('div#page-spinner').modal('hide')
    $('div#page-spinner').on 'hidden', ->
      $(this).remove()

$(document).on 'page:fetch', ->
  PageSpinner.spin()
