//
//= require rails-ujs
//= require jquery/dist/jquery.min
//= require onmount/index.js
//= require bootstrap/dist/js/bootstrap.bundle.min
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
