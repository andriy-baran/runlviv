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
});
