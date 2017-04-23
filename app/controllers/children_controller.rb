class ChildrenController < ApplicationController
  get '/children' do
    if logged_in?
      @adults = current_user.children.sort_by{|a| a.last_name}
      erb :'children/index'
    else
      redirect to '/login'
    end
  end
end
