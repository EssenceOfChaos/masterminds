console.log('~~~logging from base.js~~~');

document.addEventListener('DOMContentLoaded', function(event) {
  console.log(event);
  console.log(`Check out the baseURI bro: ${event.srcElement.baseURI}`);
  $('select.dropdown')
  .dropdown();

  $('.ui.checkbox')
  .checkbox()
;

});
