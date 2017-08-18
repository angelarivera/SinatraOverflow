get '/question/:id' do
  @question = Question.find(params[:id])


end