enable :sessions # is this actually required? REVIEW

#####  ### # REGISTRATION # ### #####
get '/register' do
  erb :'sessions/register'
end

post '/register' do
  @user = User.create({
    username: params[:username] ,
    email: params[:email] ,
    password: params[:password]
    })
    @user.password = params[:password]

    if @user
      login(@user)
      redirect '/'
    else
      redirect '/register'
    end
  end


#####  ### # LOGIN # ### #####
get '/login' do
  erb :'sessions/login'
end

post '/login' do
  user = User.authenticate(params[:email], params[:password])
  if user
    login(user)
    redirect "/"
  else
    redirect '/login'
  end
end


#####  ### # LOGOUT # ### #####
delete '/logout' do
  logout
  redirect '/'
end
