class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :'user/signup'
    end
  end

  



end
