get '/question/:id' do
  @question = Question.find(params[:id])
  @answers = @questoin.answers
  @comments = @answers.comments
  erb :'show'
end