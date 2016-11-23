$(document).ready(function() {
  $('.host_content').show();
  $('.player_content').hide();
  $(".tab").on('click', function(event) {
    $('.active').removeClass('active')
    $(this).addClass('active');
    if ($('#host').hasClass('active')) {
      $('.host_content').show();
      $('.player_content').hide();
    } else {
      $('.host_content').hide();
      $('.player_content').show();
    }
  });
});


