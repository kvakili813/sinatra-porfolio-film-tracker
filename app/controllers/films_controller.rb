class FilmsController < ApplicationController

  get '/films/new' do
    if logged_in?
      erb :'films/new'
    else
      redirect to '/login'
    end
  end

  post '/films' do
    if logged_in?
      @genre = Genre.create(name: params[:new_film][:genre])
      @film = Film.new
      @film.title = params[:new_film][:title]
      @film.year = params[:new_film][:year]
      @film.
