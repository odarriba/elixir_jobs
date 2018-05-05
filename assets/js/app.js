import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import "jquery";
import * as particles from "./app/particles.js";

function navbarScroll() {
  var navbar = document.getElementsByClassName("navbar is-fixed-top")[0];
  if (navbar && (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50)) {
    navbar.classList.remove("is-transparent");
  } else {
    navbar.classList.add("is-transparent");
  }
}

document.addEventListener("DOMContentLoaded", function () {
  window.onscroll = navbarScroll;

  particles.initParticles();
  navbar.initNavbar();

  $(".offer-new form button#preview").click(function (evt) {
    evt.preventDefault();

    var form = $(this).closest("form"),
      form_data = $(form).serialize(),
      $preview_div = $(".offer-new .offer-preview");

    $.post($(this).data("url"), form_data, function (res) {
      $preview_div.show();
      $preview_div.html(res);

      $('html, body').animate({
        scrollTop: $preview_div.offset().top
      }, 'slow');
    });
  });
});
