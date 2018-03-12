$(document).on('page:load, turbolinks:load', function() {
  var form = $('#new_support_message');
  var emailInput = form.find('#support_message_email');
  emailInput.on('click', function() {
    email = emailInput.data().email;
    emailInput.val(email);
    emailInput.attr('value', email);
  })

  $(".alert-dismissible").fadeTo(2000, 500).slideUp(500, function(){
    $(".alert-dismissible").alert('close');
  });
})
