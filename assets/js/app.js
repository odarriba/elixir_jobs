import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import "jquery";

jQuery(function ($) {
  $("a[data-toggle]").click(function (evt) {
    evt.preventDefault();
    var selector = $(this).data("toggle");
    $(selector).toggle();
  });

  $(".alert .close").click(function (evt) {
    evt.preventDefault();
    $(this).closest(".alert").remove();
  });
});
