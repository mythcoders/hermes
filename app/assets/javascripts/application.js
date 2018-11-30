//
//= require jquery3
//= require jquery_ujs
//= require rails-ujs
//= require popper
//= require bootstrap
//= require activestorage
//= require_tree .

$(function() {
  $('[data-clickable-row]').on('click', function () {
    var row_href;
    row_href = $(this).attr('data-href');
    if (row_href) {
      return document.location = $(this).attr('data-href');
    }
  });
});
function ShowLoader() {
  $("#pageLoading").fadeIn();
}
function HideLoader() {
  $("#pageLoading").fadeOut();
}
