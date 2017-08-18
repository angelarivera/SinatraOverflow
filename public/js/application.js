$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  new_answer();
});


var new_answer = function() {
    $('.new-answer').on('submit', function(){
      event.preventDefault();

      console.log(this)
      console.log('STOP REDIRECT')
      var $new_answer = $(this).serialize()
      var $url = $(this).attr('action')
      console.log($url)


      $.ajax( {
        method: "POST",
        url: $url,
        data: $new_answer
      })
      .done(function(response){
        console.log(response)
        $('#answers').append(response);
      });
    });
  };