$(document).ready(function() {

  new_answer();
  _up_vote();
  _down_vote();
  hide_show_question_comment();
  hide_show_answer_comment();
  new_comment();
  new_comment_on_answer();

  $('#defaultOpen').click();
  $('.new_comment_form').hide();
  $('.answer_comment_form').hide();
});

//-------------------QUESTION COMMENT---------------//
var hide_show_question_comment = function(){
  $('a.new_comment_link').click( function(e){
    e.preventDefault();
    this_form = $(this).parent().parent().find('.new_comment_form');
    if(this_form.is(":visible")){
      this_form.hide();
    }
    else{
      this_form.show();
    }
    return false;
  });
};

//-------------------ANSWER COMMENT---------------//
var hide_show_answer_comment = function(){
  $('a.answer_comment_link').click( function(e){
    e.preventDefault();
    this_form = $(this).parent().parent().find('.answer_comment_form');
    if(this_form.is(":visible")){
      this_form.hide();
    }
    else{
      this_form.show();
    }
    return false;
  });
};

//-------------------UP VOTE---------------//

var _up_vote = function() {
  $('.up-vote').on('submit', function(event){
    event.preventDefault();

    var $upvote = $(this);
    var $url = $upvote.attr('action');
    var id = $upvote.closest('article').attr('id');

    $.ajax( {
      method: "POST",
      url: $url
    })
    .done(function(response){
      $('#vote_' + id).text(response);
    })
    .fail(function(response){
      alert(response.responseText);
    });
  });
};

//-------------------DOWN VOTE---------------//

var _down_vote = function() {
  $('.down_vote').on('submit', function(event){
    event.preventDefault();

    var $downvote = $(this);
    var $url = $downvote.attr('action');
    var id = $downvote.closest('article').attr('id');

    $.ajax( {
      method: "POST",
      url: $url
    })
    .done(function(response){
      $('#vote_' + id).text(response);
    })
    .fail(function(response){
      alert(response.responseText);
    });
  });
};



//------------------------new_answer------------------------//
var new_answer = function() {
    $('.new-answer').on('submit', function(event){
      event.preventDefault();

      console.log(this)
      var $new_answer = $(this).serialize();
      var $url = $(this).attr('action');

      $.ajax( {
        method: "POST",
        url: $url,
        data: $new_answer
      })
      .done(function(response){
        $('#answers').append(response);
      });
    });
  };

  //----------------------new_comment------------------------//
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

  //----------------new_comment_on_answer-------------------//
var new_comment_on_answer = function() {
  $('.answer_comment_form').on('submit', function(event){
    event.preventDefault();

    var new_comment = $(this).serialize();
    var url = $(this).attr('action');
    var id = $(this).closest('article').attr('id');

    $.ajax({
      method: "POST",
      url: url,
      data: new_comment
    })
    .done(function(response){
      $('#answer-' + id + '-comments').append(response);
      $('.answer_comment_form').hide();
    });
  });
};
