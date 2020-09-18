//
//= require rails-ujs
//= require jquery/dist/jquery.min
//= require onmount/index.js
//= require bootstrap/dist/js/bootstrap.bundle.min
//= require bs-custom-file-input
//= require_tree .

$(function () {
  bsCustomFileInput.init()

  $('[data-clickable-row]').on('click', function () {
    var row_href
    row_href = $(this).attr('data-href')
    if (row_href) {
      return document.location = $(this).attr('data-href')
    }
  })

  var toggles = document.querySelectorAll('[data-toggle="wizard"]');
  [].forEach.call(toggles, function (toggle) {
    toggle.addEventListener('click', function (e) {
      e.preventDefault()

      // Toggle tab
      $(toggle).tab('show').removeClass('active')
    })
  })
})
function ShowLoader() {
  $("#pageLoading").fadeIn()
}
function HideLoader() {
  $("#pageLoading").fadeOut()
}
