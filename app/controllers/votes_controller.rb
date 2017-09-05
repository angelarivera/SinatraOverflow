post '/questions/:id/up_vote' do
  @question = Question.find(params[:id])
  @vote = @question.votes.new(vote_value: 1, user_id: session[:id])

  if @vote.save
    if request.xhr?
      @question.total_votes.to_s
    else
      redirect "/questions/#{@question.id}"
    end
  else
    status 422
    @errors = @vote.errors.full_messages
  end
end

post '/questions/:id/down_vote' do
  @question = Question.find(params[:id])
  @vote = @question.votes.new(vote_value: -1, user_id: session[:id])

  if @vote.save
    if request.xhr?
      @question.total_votes.to_s
    else
      redirect "/questions/#{@question.id}"
    end
  else
    status 422
    @errors = @vote.errors.full_messages
  end
end

post '/answers/:id/up_vote' do
  answer = Answer.find(params[:id])
  @vote = answer.votes.new(vote_value: 1, user_id: session[:id])

  if @vote.save
    if request.xhr?
      answer.points.to_s
    else
      redirect "/questions/#{answer.question_id}"
    end
  else
    status 422
    @errors = @vote.errors.full_messages
  end
end

post '/answers/:id/down_vote' do
  answer = Answer.find(params[:id])
  @vote = answer.votes.new(vote_value: -1, user_id: session[:id])

  if @vote.save
    if request.xhr?
      answer.points.to_s
    else
      redirect "/questions/#{answer.question_id}"
    end
  else
    status 422
    @errors = @vote.errors.full_messages
  end
end