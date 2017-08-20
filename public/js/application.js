$(document).ready(function() {

  new_answer();
  _up_vote();
  _down_vote();
  new_comment();

  //document.getElementById("defaultOpen").click();
  $('#defaultOpen').click();
  $('.new_comment_form').hide();
  $('.answer_comment_form').hide();

  $('a.new_comment_link').click( function(e){
    e.preventDefault();
    if($('.new_comment_form').is(":visible")){
      $('.new_comment_form').hide();
    }
    else{
      $('.new_comment_form').show();
    }
    return false;
  });

  // $('a.answer_comment_link').click( function(e){
  //   e.preventDefault();
  //   console.log(e);
  //   console.log(e.target);
  //   console.log(e.children);
  //   if($('.answer_comment_form').is(":visible")){
  //     $('.answer_comment_form').hide();
  //   }
  //   else{
  //     $('.answer_comment_form').show();
  //   }
  //   return false;
  // });

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

  //------------------------new_comment------------------------//
var new_comment = function() {
  $('.new_comment_form').on('submit', function(event){
    event.preventDefault();

    var new_comment = $(this).serialize();
    var url = $(this).attr('action');

    $.ajax({
      method: "POST",
      url: url,
      data: new_comment
    })
    .done(function(response){
      $('#question-comments').append(response);
      $('.new_comment_form').hide();
    });
  });
};
