class ChildrenController < ApplicationController
  get '/children' do
    if logged_in?
      @children = current_user.children.sort_by{|c| c.slug}
      erb :'children/index'
    else
      redirect to '/login'
    end
  end

  get '/children/new' do
    if logged_in?
      @adults = current_user.adults
      erb :'children/new'
    else
      redirect to '/login'
    end
  end

  get '/children/:slug' do
    if logged_in?
      @child = Child.find_by_slug(params[:slug])
      erb :'children/show'
    else
      redirect to '/login'
    end
  end

  get '/children/:id/edit' do
    if logged_in?
      @child = Child.find_by_id(params[:id])

      @adults = current_user.adults
      erb :'children/edit'
    else
      redirect to '/login'
    end
  end

  post '/children' do
    if params["child"]["first_name"] == "" || params["child"]["last_name"] == "" || params["child"]["birth_date"] == ""
      redirect to '/children/new'
    else
      child = Child.create(params[:child])
      current_user.children << child

      if params["adult"]["first_name"] != "" || params["adult"]["last_name"] != "" || params["adult"]["birth_date"] != ""
        child.adults << adult = Adult.create(params[:adult])
        current_user.adults << adult
      end

      redirect to "/children/#{child.slug}"
    end
  end

  patch '/children/:id' do
    child = Child.find_by_id(params[:id])

    if params["child"]["first_name"] == "" || params["child"]["last_name"] == "" || params["child"]["birth_date"] == ""
      redirect to "/children/#{child.id}/edit"
    else
      child.update(params[:child])

      if params["adult"]["first_name"] != "" || params["adult"]["last_name"] != "" || params["adult"]["birth_date"] != ""
        child.adults << adult = Adult.create(params[:adult])
        current_user.adults << adult
      end

      redirect to "/children/#{child.slug}"
    end
  end

  delete '/children/:id/delete' do
    child = Child.find_by_id(params[:id])

    child.delete

    redirect to '/children'
  end

end
