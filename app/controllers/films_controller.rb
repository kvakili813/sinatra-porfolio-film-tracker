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
      @film.genre_id = @genre.id
      @film.user_id = session[:user_id]
        if @film.save
          redirect "films/#{@film.id}"
        else
          flash[:message] = 'Fill correct info!'
          redirect '/films/new'
        end
      else
        redirect '/login'
      end
    end

    get '/films/:id' do
      @film = Film.find_by_id(params[:id])
        if @film.nil?
          redirect '/'
        else
          erb :'films/show'
        end
      end 
