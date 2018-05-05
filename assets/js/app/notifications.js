function initNotifications() {
  var $closeNotifications = Array.prototype.slice.call(document.querySelectorAll('.notification .delete'), 0);
  if ($closeNotifications.length > 0) {
    $closeNotifications.forEach(function ($el) {
      $el.addEventListener('click', function () {
        $el.parentElement.remove()
      });
    });
  }
}

export { initNotifications }
