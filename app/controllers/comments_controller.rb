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