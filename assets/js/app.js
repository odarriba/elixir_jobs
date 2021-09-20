import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import "jquery";
import * as particles from "./app/particles.js";
import * as navbar from "./app/navbar.js";
import * as notifications from "./app/notifications.js";

function navbarScroll() {
  var navbar = document.getElementsByClassName("navbar is-fixed-top")[0];
  var has_hero = document.getElementsByClassName("hero main").length > 0;

  if (!has_hero) {
    return true;
  }

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
  notifications.initNotifications();
  navbarScroll();

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
