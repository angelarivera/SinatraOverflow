$(document).ready(function() {
  document.getElementById("defaultOpen").click();
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  new_answer();
  _up_vote();
  _down_vote();
});

//-------------------UP VOTE---------------//

var _up_vote = function() {
  $('.up-vote').on('submit', function(event){
    console.log("HELLOOOO")
    event.preventDefault();


    console.log("STOP REDIRECT")
    var $upvote = $(this)

    var $url = $upvote.attr('action')
    var id = $upvote.closest('article').attr('id')

    console.log($upvote)
    console.log($url)
    console.log(id)


    $.ajax( {
      method: "POST",
      url: $url,

    })
    .done(function(response){
      console.log($upvote)

      $('#vote_'+ id).text(response);
    });
  });
};

//-------------------DOWN VOTE---------------//

var _down_vote = function() {
  $('.down_vote').on('submit', function(event){
    console.log("HELLOOOO")
    event.preventDefault();

    console.log("STOP REDIRECT")
    var $downvote = $(this)

    var $url = $downvote.attr('action')
    var id = $downvote.closest('article').attr('id')
    console.log($downvote)
    console.log($url)


    $.ajax( {
      method: "POST",
      url: $url,

    })
    .done(function(response){
      console.log(response)
      $('#vote_'+id).text(response);
    });
  });
};



//------------------------new_answer------------------------//
var new_answer = function() {
    $('.new-answer').on('submit', function(event){
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