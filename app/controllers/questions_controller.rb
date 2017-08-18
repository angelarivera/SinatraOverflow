get '/question/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers

  erb :'show'
end


post '/question/:id' do
  #   @question = Question.find(params[:id])
  #   @new_answer = Answer.create(description: params[:description], question_id: @question.id, answerer_id: session[:id])
  # if @new_answer.save
  #   status 200
  #   if request.xhr?
  #     @new_answer
  #   else
  #     #redirect somewhere?
  #   end
  # else
  #   #Throw error
  # end
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

get '/questions/:id' do
end

get '/questions/new' do
end



post '/answer/:id/vote' do
  post = Answer.find(params[:id])
  post.votes.create(value: 1)
  redirect "/questions" #what is the route for this

  #still need down vote.. maybe a whole other route??
end