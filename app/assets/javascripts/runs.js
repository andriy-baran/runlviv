$(document).on('page:load, turbolinks:load', function() {
  $('.date-input').pickadate({hiddenName: true});
  $('.time-input').pickatime({
    format: 'HH:i',
    formatSubmit: 'HH:i',
    formatLabel: 'HH:i',
    hiddenName: true
  });

  if ( $('.date-input').length > 0) {
    var datePicker = $('.date-input').pickadate('picker');
    datePicker.set('min', new Date)
    datePicker.set('view', $('.date-input').val())
  }

  $('img').on('load', function(){
    optimizeLayout();
  })

  optimizeLayout();
});


$(window).on('resize', function(){
  optimizeLayout();
})

function optimizeLayout() {
  var header = $('header').height();
  var footer = $('footer').height();
  if($(window).height() < ($('main').height() + header + footer)) {
    $('header').css('position', 'inherit');
    $('.cover-container').css('position', 'inherit');
    $('footer').css('position', 'inherit');
  } else {
    $('header').css('position', 'fixed');
    $('.cover-container').css('position', 'absolute');
    $('footer').css('position', 'fixed');
  }
}
