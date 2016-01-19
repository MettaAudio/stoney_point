$(function(){
  $('.js-show-more').on('click', '.js-more-btn', function() {
    $(this).siblings('.show-more').toggleClass('truncate');
    if($(this).html() == "Click to read more") {
      $(this).html('Click to show less')
    }
    else {
      $(this).html('Click to read more')
    }
  });

  $('.js-i-accept').on('click', function() {
    if ($(this).prop('checked') == true) {
      $('.js-submit').removeClass('disabled');
      $('.js-submit').html('Save');
    } else {
      $('.js-submit').addClass('disabled');
      $('.js-submit').html('Please accept the waiver...');
    }
  });
});