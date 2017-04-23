class ChildrenController < ApplicationController
  get '/children' do
    if logged_in?
      @adults = current_user.children.sort_by{|a| a.last_name}
      erb :'children/index'
    else
      redirect to '/login'
    end
  end

  get '/children/new' do
    if logged_in?
      @adults = current_user.adults
      erb :'adults/new'
    else
      redirect to '/login'
    end
  end

  post '/children' do
    if params["child"]["first_name"] == "" || params["child"]["last_name"] == "" || params["child"]["birth_date"] == ""
      redirect to '/children/new'
    else
      child = Child.create(params[:adult])
      current_user.children << child

      if params["adult"]["first_name"] != "" || params["adult"]["last_name"] != "" || params["adult"]["birth_date"] != ""
        child.adults << adult = Child.create(params[:child])
        current_user.adults << adult
      end

      redirect to "/children/#{child.slug}"
    end
  end

end
