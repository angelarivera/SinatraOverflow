patch '/questions/:question_id/answers/:id' do 
  question = Question.find(params[:question_id])
  answer = Answer.find(params[:id])

  question.mark_best_answer(answer)

  redirect "/questions/#{question.id}"
end 