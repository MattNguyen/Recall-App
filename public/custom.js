// "#create_note".onSubmit(function(event) {
//     alert("womp womp");
//     // event.stop();
//     // this.send({
//     //     onSuccess: function() {
//     //         $('all_messages_area').update(this.responseText);
//     //     }
//     // });
// })


document.ready = function() {
    $('#create_note').bind('click', function(event) {
        event.preventDefault();
        doSomething();
    });
}



function doSomething() {
    // console.log($('#addNoteForm'));
    var contentBoxObject = $('#contentBox');

    $.ajax({
      type: "POST",
      url: "/",
      data: { "content": contentBoxObject.val() },
      success: function(data) {
          var myDataObject = $(data);
          // myDataObject.css({opacity: 0});
          $('#all_messages_area').prepend(myDataObject);
          myDataObject.css({opacity: 0}).animate({opacity:1});
          contentBoxObject.val('');
      },

    });
    return false;
}
