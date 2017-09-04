#####  ### # REGISTRATION # ### #####
get '/register' do
  erb :'sessions/register'
end

post '/register' do
  @user = User.new({
    username: params[:username] ,
    email: params[:email] ,
    password: params[:password]
    })
    #@user.password = params[:password]

    if @user.save
      login(@user)
      redirect '/'
    else
      @errors = @user.errors.full_messages
      erb :'sessions/register'
    end
  end


#####  ### # LOGIN # ### #####
get '/login' do
  erb :'sessions/login'
end

post '/login' do
  user = User.authenticate(params[:email], params[:password])
  if user.nil?
    @errors = ["Your email and password do not match our records, please try again."]
    erb :'/sessions/login'
  else
    login(user)
    redirect "/"
  end
end


#####  ### # LOGOUT # ### #####
get '/logout' do
  logout
  redirect '/'
end