get '/question/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers
  # @comments = @answers.comments
  erb :'show'
end


#should probably go in an answer controller
# post '/answer/:id/vote' do
#   post = Answer.find(params[:id])
#   post.votes.create(value: 1)
#   redirect "/questions" #what is the route for this

#   #still need down vote.. maybe a whole other route??
# end