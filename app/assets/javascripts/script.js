$(function(){

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  $('.delete_feed').click(function(){

    var user_feed_id = $(this).data('userfeed-id');
     //ajax stuff
    // once ajax request returns , then ->
    $.ajax({
      type: "DELETE",
      url: "/feed_users/"+user_feed_id,
      }).done(function( msg ) {
         });

    $(this).remove();
    $(this).parent().remove();
    $('#'+user_feed_id).parent().remove();
//TODO: Stop page refresh
  })


//// Entry functionality////
    $('.hide-content').click(function() {
    var parent=$(this).parent();
     // $("html, body").animate({ scrollTop: 0 }, 600);

     // debugger
    parent.addClass("hide");
  });
//Hides all other entries, open the clicked one
  $('.entry').find('.entry-title').click(function() {
    var parent=$(this).parent();
    // debugger
     // TODO: Add the scrolling to position
    $('.content').removeClass("hide");
    $('.content').addClass("hide");
    $("html, body").animate({ scrollTop: $(this).position().top }, 600);

    parent.find(".content").first().toggleClass("hide");

    var entry_id=(parent.data('entry-id'));

    $.ajax({
      type: "POST",
      url: "/entry_users",
      data:
       {
        "entry_id": ""+entry_id,
        "read": "true"
        },
      }).done(function( msg ) {

         });
  });

  //Marks the entry as unread

  $('.unread').click(function() {

      var parent=$(this).parent();
      parent.toggleClass("hide");
      console.log(parent.find(".content").first());
      entry_id = parent.parent().data('entry-id');

      $.ajax({
      type: "POST",
      url: "/entry_users",
      data:
       {
        "entry_id": ""+entry_id,
        "read": "false"
       },
    }).done(function( msg ){});
  });

    $('.archive').click(function() {
      console.log($(this));
      var parent=$(this).parent();
      entry_id = parent.parent().data('entry-id');
      $.ajax({
      type: "POST",
      url: "/entry_users",
      data:
       {
        "entry_id": ""+entry_id,
        "archive": "true"
       },
    }).done(function( msg ){});
  });

  $('.favourite').click(function() {

      entry_id = $(this).data('entry-id');
      $.ajax({
      type: "POST",
      url: "/entry_users",
      data:
       {
        "entry_id": ""+entry_id,
        "archive": "true",
        "favourite": "true"
       },
    }).done(function( msg ){});
  });

  $('.unfavourite').click(function() {

      entry_id = $(this).data('entry-id');
      $.ajax({
      type: "POST",
      url: "/entry_users",
      data:
       {
        "entry_id": ""+entry_id,
        "archive": "false",
        "favourite": "false"
       },
    }).done(function( msg ){});
      $('#fav'+entry_id).addClass("hide")
  });
///End Entry Functionalit/Interaction



//PUBLIC AND PRIVATE FEED UPDATE

  $('.private-toggle-button').click(function(){

    user_feed_id = $(this).data('userfeed-id');
    console.log(user_feed_id)
    $.ajax({
      type: "PUT",
      data: {"is_private": "true"},
      url: "/feed_users/"+user_feed_id,
      }).done(function( msg ) {
         });
  });
  $('.public-toggle-button').click(function(){

    user_feed_id = $(this).data('userfeed-id');

    $.ajax({
      type: "PUT",
      data: {"is_private": "false"},
      url: "/feed_users/"+user_feed_id,
      }).done(function( msg ) {
         });

  });


//CHANGE FEED CATEGORY

  $('.submit-category-update').click(function(){
    new_category = $(this).prev().val()
    user_feed_id = $(this).data('userfeed-id');

  $.ajax({
    type: "PUT",
    data: {"new_category": new_category},
    url: "/feed_users/"+user_feed_id+"/update_category",
    }).done(function( msg ) {
        document.location.href = document.location.href
       });

  });


})
