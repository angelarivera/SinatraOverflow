get '/questions/new' do
  if current_user
    erb :'questions/new'
  else
    erb :'404'
  end
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers

  erb :'show'
end

post '/questions/:id/answers' do
    @question = Question.find(params[:id])
    @new_answer = Answer.new(description: params[:description], question_id: @question.id, answerer_id: session[:id])
  if @new_answer.save
    status 200
    if request.xhr?
      erb :'_answers', layout: false, locals: {answer: @new_answer}
    else
      redirect "/questions/#{@question.id}"
    end
  else
    status 422
  end
end

post '/questions/:id/comments' do
  @question = Question.find(params[:id])
  @comment = @question.comments.new(description: params[:comment], user_id: session[:id])

  if @comment.save
    status 200
    if request.xhr?
      erb :'_comments', layout: false, locals: {comment: @comment}
    else
      redirect "/questions/#{@question.id}"
    end
  else
    status 422
  end
end

post '/answers/:id/comments' do
  @answer = Answer.find(params[:id])
  @comment = @answer.comments.new(
    description: params[:comment], user_id: session[:id])

  if @comment.save
    status 200
    if request.xhr?
      erb :'_comments', layout: false, locals: {comment: @comment}
    else
      redirect "/questions/#{@answer.question_id}"
    end
  else
    status 422
  end
end

# post '/answer/:id/vote' do
#   post = Answer.find(params[:id])
#   post.votes.create(value: 1)
#   redirect "/questions" #what is the route for this

#   #still need down vote.. maybe a whole other route??
# end

post '/answers/:id/up_vote' do
  answer = Answer.find(params[:id])
  @vote = answer.votes.new(vote_value: 1, user_id: session[:id])

  if @vote.save
    if request.xhr?
      p "Found ajax"
      answer.points.to_s
    else
      p "Refreshing"
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

get '/questions' do
  # @questions = Question.most_recent
  erb :'questions/index'
end

post '/questions' do
  @question = Question.new(title: params[:title], description: params[:description], author_id: session[:id])

  if @question.save
    redirect "/questions"
  else
    @errors = @question.errors.full_messages
    erb :'questions/new'
  end
end

