$(document).on('ready', function() {
  $('.date-input').pickadate({hiddenName: true});
  $('.time-input').pickatime({
    format: 'HH:i',
    formatSubmit: 'HH:i',
    formatLabel: 'HH:i',
    hiddenName: true
  });

  var datePicker = $('.date-input').pickadate('picker');
  datePicker.set('min', new Date)
  datePicker.set('view', $('.date-input').val())
});