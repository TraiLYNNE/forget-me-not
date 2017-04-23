class AdultsController < ApplicationController
  get '/adults/new' do
    if logged_in?
      @children = current_user.children
      erb :'adults/create_adult'
    else
      redirect to '/login'
    end
  end

  post '/adults' do

  end
end
