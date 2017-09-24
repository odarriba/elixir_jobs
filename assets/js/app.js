import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import "jquery";
import "rrssb/js/rrssb";

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

  $(".offer-new form button#preview").click(function(evt) {
    evt.preventDefault();

    var form = $(this).closest("form"),
        form_data = $(form).serialize(),
        $preview_div = $(".offer-new .offer-preview");

    $.post($(this).data("url"), form_data, function(res){
      $preview_div.show();
      $preview_div.html(res);

      $('html, body').animate({
        scrollTop: $preview_div.offset().top
      }, 'slow');
    });
  });

  $(".rrssb-buttons").rrssb({
    title: document.title,
    url: document.location.href,
    description: $('meta[name=description]').attr("content")
  });
});
