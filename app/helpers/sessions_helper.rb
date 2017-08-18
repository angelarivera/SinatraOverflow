helpers do
  def login(user)
    session[:id] = user.id
  end

  def logout
    session[:id] = nil
  end

  def current_user
    User.find( session[:id] ) if session[:id]
    # or User.find_by( session[:id] )  <=REVIEW
  end
end
