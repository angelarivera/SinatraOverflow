enable :sessions # is this required?

get '/login' do
  erb :'sessions/login'
end

post '/login' do
  user = User.authenticate(params[:email], params[:password])
  if user
    login(user)
    redirect "/users/#{user.id}"
  else
    redirect '/login'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'sessions/show'
end


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
    login(user)
    redirect "/users/#{@user.id}"
  else
    redirect '/register'
  end
end


delete '/logout' do
  logout
  redirect '/'
end

# To go in the layout...
# <% if current_user %>
#     <button> Logout </button
# <% else %>
#     <button> Login</button>
#     <button> Register </button>
# <% end %>
