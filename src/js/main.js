// Toggle .header-scrolled class to #header when page is scrolled
$(window).scroll(function() {
  if ($(this).scrollTop() > 100) {
    $('#header').addClass('header-scrolled');
    $('#header').removeClass('navbar-margin');
  } else {
    $('#header').addClass('navbar-margin');
    $('#header').removeClass('header-scrolled');
  }
});
