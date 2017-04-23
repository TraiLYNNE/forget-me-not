class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(username:params[:username], email: params[:email], password:params[:password])
      session[:user_id] = user.id

      redirect to '/'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      redirect to '/signup'
    end
  end
end
