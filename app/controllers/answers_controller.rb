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

patch '/questions/:question_id/answers/:id' do 
  question = Question.find(params[:question_id])
  answer = Answer.find(params[:id])

  question.mark_best_answer(answer)

  redirect "/questions/#{question.id}"
end 