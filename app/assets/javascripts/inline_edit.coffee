StoneyPoint.InlineEditing =
  defaultOptions:
    selector: ".editable"

  init: (options = {}) ->
    if options.selector && $(options.selector).length == 0
      console.error "#{options.selector} not found in page"

    options = $.extend({}, @defaultOptions, options)

    # Text areas and multiple selects are special cases
    textAreas = $(options.selector).filter("[data-type=textarea]")
    multipleSelects = $(options.selector).filter(".multiple-select")
    checkLists = $(options.selector).filter("[data-type=checklist]")
    datePickers = $(options.selector).filter("[data-type=date]")

    $(options.selector).not(textAreas).not(multipleSelects).not(datePickers).editable()

    @initEditableMultipleSelect(multipleSelects)
    @initTextAreas(textAreas)
    @initEditableDatepickers(datePickers)
    @initCheckLists(checkLists)

    $(options.selector).on "save", (e, params) ->
      $(e.target).attr("data-value", params.newValue)

  initCheckLists: (scope)->
    $(scope).editable
      display: (value, sourceData)->
        # display checklist as comma-separated values
        html = []
        checked = $.fn.editableutils.itemsByValue(value, sourceData)
        if checked.length
          $.each checked, (i, v) ->
            html.push($.fn.editableutils.escape(v.text))
          $(this).html(html.join(', '))
        else
          $(this).empty()

  initEditableDatepickers: (scope)->
    $(scope).editable
      tpl: "<div></div>"
      clear: false
      showbuttons: false

  initEditableMultipleSelect: (scope)->
    $(scope).editable
      success: (response, _newValue)->
        # Grr! newValue is returned as an array of strings
        # Using response[:name] instead
        el = $(this)
        key = el.data("name")
        el.data("value", response[key])

      display: (value, sourceData)->
        unless value?.length
          $(this).empty()
          return

        html = []
        ids = value

        matchedOpts = $.map ids, (id)->
          $.grep sourceData, (datum)->
            datum.value == parseInt(id)

        $.each matchedOpts, ->
          html.push($.fn.editableutils.escape(this.text))

        $(this).html(html.join(", "))

    $(document).on "shown.bs.popover", (e)->
      multiSelect = $(e.target)
        .next(".popover")
        .find("select[multiple]")

      values = $(e.target).data("value")

      $(multiSelect).find("option").each ->
        opt = $(this)[0]
        if $.inArray(parseInt(this.value), values) > -1
          $(opt).prop("selected", true)
        else
          $(opt).prop("selected", false)

      $(multiSelect).chosen
        width: "300px"

  initTextAreas: (scope)->
    $(scope).editable
      display: (value, sourceData)->
        limit = $(this).data("char-limit") || 30

        if value.length > limit
          truncatedValue = value.slice(0, limit)
          $(this).html($.fn.editableutils.escape("#{truncatedValue}..."))
        else
          $(this).html($.fn.editableutils.escape(value))

  initHexColorEditHandler: (attributeName) ->
    $(".editable[data-name='" + attributeName + "']").on "save", (e, params) ->
      $(e.target).parent().attr("data-color", "#{params.submitValue}")

$(document).on "change", ".popover .chosen-select", (e) ->
  $(e.target).parents('.popover').data('bs.popover').reposition_popover()

$(document).on "chosen:ready", ".popover .chosen-select", (e) ->
  $(e.target).parents('.popover').data('bs.popover').reposition_popover()

$(document).on "shown.bs.popover", (e) ->

  scroll_prime = 0
  if $(e.target).parents('.horizontal-scroll').length
    scroll_prime = $(e.target).parents('.horizontal-scroll').get(0).scrollLeft

  $popover = $('#' + e.target.getAttribute('aria-describedby'))
  return unless $popover.length
  center = $popover.find('.arrow').offset().left

  $popover
    .attr('data-shiftx', scroll_prime)
    .attr('data-center', center)
    .css({visibility: "visible"})
    .find('select:not([multiple])')
    .addClass('chosen-select')
    .chosen({ allow_single_deselect: true, disable_search_threshold: 10, width: "auto" })

  # We need some breathing room for the chosen multi selects
  $popover
    .attr('data-shiftx', scroll_prime)
    .attr('data-center', center)
    .css({visibility: "visible"})
    .find('select[multiple]')
    .addClass('chosen-select')
    .chosen({width: "300px" })


$(document).on "hide.bs.popover", (event) ->
  $(event.target).next('.popover').css({
    marginLeft: 0,
    visibility: "hidden"
    })

