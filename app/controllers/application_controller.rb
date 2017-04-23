require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "trailynne"
  end

  get '/' do
    erb :index
  end

  patch '/adults/:id' do
    adult = Adult.find_by_id(params[:id])

    if params["adult"]["first_name"] == "" || params["adult"]["last_name"] == "" || params["adult"]["birth_date"] == ""
      redirect to "/adults/#{adult.id}/edit"
    else
      adult.update(params[:adult])

      if params["child"]["first_name"] != "" || params["child"]["last_name"] != "" || params["child"]["birth_date"] != ""
        adult.children << child = Child.create(params[:child])
        current_user.children << child
      end

      redirect to "/adults/#{adult.slug}"
    end
  end

  # patch '/children/:id' do
  #   child = Child.find_by_id(params[:id])
  #
  #   if params["child"]["first_name"] == "" || params["child"]["last_name"] == "" || params["child"]["birth_date"] == ""
  #     redirect to "/children/#{child.id}/edit"
  #   else
  #     child.update(params[:child])
  #
  #     if params["adult"]["first_name"] != "" || params["adult"]["last_name"] != "" || params["adult"]["birth_date"] != ""
  #       child.adults << adult = Adult.create(params[:adult])
  #       current_user.adults << adult
  #     end
  #
  #     redirect to "/children/#{children.slug}"
  #   end
  # end

  delete '/adults/:id/delete' do
    adult = Adult.find_by_id(params[:id])

    adult.delete

    redirect to '/adults'
  end

  # delete '/children/:id/delete' do
  #   child = Child.find_by_id(params[:id])
  #
  #   children.delete
  #
  #   redirect to '/children'
  # end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
