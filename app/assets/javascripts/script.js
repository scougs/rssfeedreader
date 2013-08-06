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
  })

  $('.entry').find('h3').click(function() {
    var parent=$(this).parent();
    parent.find("div").toggleClass("hide");
    var entry_id=console.log(parent.data('entry-id'));
    console.log(this)
    $.ajax({
      type: "POST",
      url: "/entry_users",
      data:  entry_id,
      }).done(function( msg ) {

         });
  });

})
