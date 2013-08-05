$(function(){
  $('.delete_feed').click(function(){
    user_feed_id = $(this).data('userfeed-id');
    //ajax stuff
    // once ajax request returns , then ->
    $.ajax({
      type: "DELETE",
      url: "/feed_users/"+user_feed_id,
      // data: { name: "John", location: "Boston" }
      }).done(function( msg ) {
         });
    $(this).parent().prev().remove()
    $(this).parent().remove()
  })

})
