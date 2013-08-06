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

  $('.entry').find('h3').click(function() {
    var parent=$(this).parent();
    parent.find("div").first().toggleClass("hide");
    var entry_id=console.log(parent.data('entry-id'));
    console.log(this)
    // $.ajax({
    //   type: "POST",
    //   url: "/entry_users",
    //   data:  entry_id,
    //   }).done(function( msg ) {

    //      });
  });

//PUBLIC AND PRIVATE FEED UPDATE

  $('.private-toggle-button').click(function(){

    user_feed_id = $(this).data('userfeed-id');

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
