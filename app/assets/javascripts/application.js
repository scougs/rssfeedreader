// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {

  var toggleSidebar = function() {

    $('.sidebar').animate({
        width: 'toggle'
      }, 000);

    var text = $('#sidebar-toggle-button').text();
    $('#sidebar-toggle-button').text(
      text == "Hide Sidebar" ? "Show Sidebar" : "Hide Sidebar");

    $('.main').toggleClass('span7 offset1');
    $('.main').toggleClass('span12');
    $('.main').toggleClass('no-sidebar');
    }

  $('a.toggle-sidebar').click(toggleSidebar);

  if ($('body').hasClass('sidebar-hidden')) {
    toggleSidebar();
  }

     // SEARCH FUNCTION USERS

  $(function() {
  $('#search').on('keyUp', function() {
    $('#search_form').submit();
  });
});




});