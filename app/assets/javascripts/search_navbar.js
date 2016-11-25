  $('.search-event').hide();
  $('#close').hide()
  if ($('.search-event').attr("hidden", true)) {
  $(".search-btn").on('click', function(event) {
      event.preventDefault();
      $('.search-btn').hide();
      $('.search-event').css('visibility', 'visible').show('slow');
      $('#close').css('visibility', 'visible').show('slow');
      $('.navbar-wagon-right').css('width', '600px')
    });
  }
  if ($('#close').attr("hidden", false)) {
    $('#close').on('click', function(event) {
      event.preventDefault();
      $('.search-event').hide('slow');
      $('#close').hide('slow');
      $('.search-btn').show('slow');
    });
  }
