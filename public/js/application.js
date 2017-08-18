$(document).ready(function() {
  document.getElementById("defaultOpen").click();
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