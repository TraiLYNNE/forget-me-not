class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(username:params[:username], email: params[:email], password:params[:password])
      session[:user_id] = user.id
    end
  end
end
