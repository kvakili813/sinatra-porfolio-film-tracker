class FilmsController < ApplicationController

  get '/films/new' do
    if logged_in?
      erb :'films/new'
    else
      redirect to '/login'
    end
  end

  
