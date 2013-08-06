$(function(){

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  $('.delete_feed').click(function(){
    user_feed_id = $(this).data('userfeed-id');

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



  $('.entry').click(function() {
    $(this).find("div").toggleClass("hide");
  })

})
