//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery-ui
//= require jquery-ui-timepicker-addon
//= require cocoon
//= require_tree .

$(function() {
  $('.topbar').dropdown();
  $('.alert-message').alert();
  $('a[data-original-title]').popover();
});
