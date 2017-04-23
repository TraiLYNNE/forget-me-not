class AdultsController < ApplicationController
  get '/adults' do
    if logged_in?
      @adults = current_user.adults.sort_by{|a| a.last_name}
      erb :'adults/index'
    else
      redirect to '/login'
    end
  end

  get '/adults/new' do
    if logged_in?
      @children = current_user.children
      erb :'adults/create_adult'
    else
      redirect to '/login'
    end
  end

  get '/adults/:slug' do
    if logged_in?
      @adult = Adult.find_by_slug(params[:slug])
      erb :'adults/show'
    else
      redirect to '/login'
    end
  end

  get '/adults/:slug/edit' do
    if logged_in?
      @adult = Adult.find_by_slug(params[:slug])
      erb :'adults/edit'
    else
      redirect to '/login'
    end
  end

  post '/adults' do
    if params["adult"]["first_name"] == "" || params["adult"]["last_name"] == "" || params["adult"]["birth_date"] == ""
      redirect to '/adults/new'
    else
      adult = Adult.create(params[:adult])
      current_user.adults << adult

      if params["child"]["first_name"] != "" || params["child"]["last_name"] != "" || params["child"]["birth_date"] != ""
        adult.children << child = Child.create(params[:child])
        current_user.children << child
      end

      redirect to "/adults/#{adult.slug}"
    end
  end
end
