
get '/question/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers

  erb :'show'
end


post '/questions/:id/answers' do
    @question = Question.find(params[:id])
    @new_answer = Answer.create(description: params[:description], question_id: @question.id, answerer_id: session[:id])
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

get '/answers/:id/comments' do
  @comment = Comment.create( )
end


# post '/answer/:id/vote' do
#   post = Answer.find(params[:id])
#   post.votes.create(value: 1)
#   redirect "/questions" #what is the route for this

#   #still need down vote.. maybe a whole other route??
# end

post '/answers/:id/up_vote' do
  answer = Answer.find(params[:id])
  answer.votes.create(vote_value: 1)
    if request.xhr?
      answer.points.to_s
    else
      redirect "/questions"
    end
end

post '/answers/:id/down_vote' do
  answer = Answer.find(params[:id])
  answer.votes.create(vote_value: -1)
    if request.xhr?
      answer.points.to_s
    else
      redirect "/questions"
    end
end


post '/questions/:id/up_vote' do
  @question = Question.find(params[:id])
  @question.votes.create(vote_value: 1)

    if request.xhr?
      @question.total_votes.to_s
    else
      redirect "/question/#{@question.id}"
    end

end

post '/questions/:id/down_vote' do
  question = Question.find(params[:id])
  question.votes.create(vote_value: -1)
    if request.xhr?
      question.total_votes.to_s #calls votes method...
    else
    end

end

get '/questions' do
  # @questions = Question.most_recent
  erb :'questions/index'
end

get '/questions/new' do
  if current_user
    erb :'questions/new'
  else
    erb :'404'
  end
end

post '/questions' do
  # TODO: Remove when user session is ready
  session[:user_id] = 1
  @question = Question.new(title: params[:title], description: params[:description], author_id: session[:user_id])

  if @question.save
    redirect "/questions"
  else
    @errors = @question.errors.full_messages
    erb :'questions/new'
  end
end

