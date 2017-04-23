class UsersController < ApplicationController
  get '/users/home' do
    if logged_in?
      erb :'users/show'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/users/home'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/users/home'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(username:params[:username], email: params[:email], password:params[:password])
      session[:user_id] = user.id

      redirect to '/users/home'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/home"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
