get 'user/:id' do 
  @users = User.find(params[:id])
  erb :'user/show'
end 