class AdultsController < ApplicationController
  get '/adults/:slug' do

  end

  get '/adults/new' do
    if logged_in?
      @children = current_user.children
      erb :'adults/create_adult'
    else
      redirect to '/login'
    end
  end

  post '/adults' do
    adult = Adult.create(params[:adult])

    adult.children << child = Child.create(params[:child]) if !params["child"]["first_name"].empty? || !params["child"]["last_name"].empty?

    adult.user_id = current_user.id
    adult.save

    child.user_id = current_user.id
    child.save

    redirect to '/users/home'
  end
end
