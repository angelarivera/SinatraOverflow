get '/questions/new' do
  if current_user
    erb :'questions/new'
  else
    erb :'404'
  end
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = @question.non_best_answers.sort_by{ |answer| -answer.points }
  # displaying all non best answers
  @bestanswer = @question.best_answers.first

  erb :'show'
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