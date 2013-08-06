$(function(){

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $('.delete_feed').click(function(){
    user_feed_id = $(this).data('userfeed-id');
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
  })

  $('.entry').click(function() {
    $(this).find("div").toggleClass("hide");
  })

})
