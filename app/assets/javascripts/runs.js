$(document).on('ready', function() {
  $('.date-input').pickadate();
  $('.time-input').pickatime({format: 'HH:i', formatSubmit: 'HH:i', formatLabel: 'HH:i'});
});