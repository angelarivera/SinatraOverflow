get '/questions' do
  @questions = Question.most_recent
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

