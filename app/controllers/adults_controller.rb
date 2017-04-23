class AdultsController < ApplicationController
  get '/adults/new' do
    if logged_in?
      erb :'adults/create_adult'
    else
      redirect to '/login'
    end
  end
end
