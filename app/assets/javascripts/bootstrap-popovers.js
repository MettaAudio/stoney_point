$.fn.popover.Constructor.prototype.reposition_popover = function () {
  var $tip = this.tip()
  var placement = typeof this.options.placement == 'function' ?
          this.options.placement.call(this, $tip[0], this.$element[0]) :
          this.options.placement

  var autoToken = /\s?auto?\s?/i
  var autoPlace = autoToken.test(placement)
  if (autoPlace) placement = placement.replace(autoToken, '') || 'top'


  $tip
    .detach()
    .css({ top: 0, left: 0, display: 'block' })
    .addClass(placement)
    .data('bs.' + this.type, this)

  this.options.container ? $tip.appendTo(this.options.container) : $tip.insertAfter(this.$element)


  var pos = this.getPosition()
  var actualWidth  = $tip[0].offsetWidth
  var actualHeight = $tip[0].offsetHeight

  if (autoPlace) {
    var orgPlacement = placement
    var $container   = this.options.container ? $(this.options.container) : this.$element.parent()
    var containerDim = this.getPosition($container)

    placement = placement == 'bottom' && pos.bottom + actualHeight > containerDim.bottom ? 'top'    :
                placement == 'top'    && pos.top    - actualHeight < containerDim.top    ? 'bottom' :
                placement == 'right'  && pos.right  + actualWidth  > containerDim.width  ? 'left'   :
                placement == 'left'   && pos.left   - actualWidth  < containerDim.left   ? 'right'  :
                placement

    $tip
      .removeClass(orgPlacement)
      .addClass(placement)
  }

  calculatedOffset = this.getCalculatedOffset(placement, pos, actualWidth, actualHeight)

  this.applyPlacement(calculatedOffset, placement)
};

// Allow popovers to fetch content via ajax if they have a data-popover-source field
$(document).on("click", "[data-popover-source]", function(e) {
  e.preventDefault()
  $popoverTrigger = $(e.target).closest("[data-popover-source]")
  $.ajax({
    method: "GET",
    dataType: "html",
    url: $popoverTrigger.data("popover-source"),
    success: function(data) {
      $popoverTrigger.popover({content: data})
      $popoverTrigger.popover("show")
    }
  })
  $popoverTrigger.on("hidden.bs.popover", function(e) {
    $popoverTrigger.popover("destroy")
  })
})

$(document).on("hide.bs.tab", function(e) {
  $toggle = $(e.target.hash).find('[aria-describedby]');
  $('body > #' + $toggle.attr("aria-describedby") + '.popover').popover('hide');
});

// Because Tooltip is poorly written hide doesn't mark the tool as now actually closed and
// hidden, so we have to build that logic in ourself.
var original_hide = $.fn.popover.Constructor.prototype.hide;
$.fn.popover.Constructor.prototype.hide = function(callback) {
  original_hide.apply(this, [callback]);
  // YES WE ARE IN FACT CLOSED NOW
  this.inState = { click: false, hover: false, focus: false };
  return this;
}

// Trap clicks (which call .toggle) and make sure the click event does not
// propogate all the way up to the body, so as to keep the body on-click
// from driving us mad.
var original_toggle = $.fn.popover.Constructor.prototype.toggle;
$.fn.popover.Constructor.prototype.toggle = function(event) {
  event.stopPropagation()
  original_toggle.apply(this, [event]);
}

// Ignore x-editable popovers, it handles itself
function closePopovers(popovers) {
  popovers.not(".editable-container").popover("hide");
}

$(document).on("show.bs.popover", function(event) {
  closePopovers($('.popover').not(event.target))
});

// The next 3 make sure the user can click on the body and close the popover
$(document).on("hidden.bs.popover", function() {
  if ($('body > .popover').length == 0) {
    $('body').removeClass('popovers-open');
  }
});

$(document).on("shown.bs.popover", function() {
  if ($('body > .popover').length > 0) {
    $('body').addClass('popovers-open');
  }
});

$(document).on("click", "body.popovers-open", function(event) {
  var $clicked = $(event.target);

  if ((!event.target.classList.contains('popover') && $clicked.parents('.popover').length == 0)) {
    closePopovers($(".popover"))
  }
});
