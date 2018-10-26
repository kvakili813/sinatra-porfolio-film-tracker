class FilmsController < ApplicationController

  get '/films/new' do
    redirect_if_not_logged_in
      erb :'films/new'
  end

  post '/films' do
    redirect_if_not_logged_in
      if params[:genre] != ""
        @genre = Genre.find_or_create_by(name: params[:genre])
      elsif
        @genre = Genre.find_by(id: params[:genre_id])
      else
        flash[:message] = 'Fill correct info!'
        redirect '/films/new'
      end
      @film = Film.new
      @film.title = params[:title]
      @film.year = params[:year]
      @film.genre_id = @genre.id
      @film.user_id = session[:user_id]
        if @film.save
          redirect "films/#{@film.id}"
        else
          flash[:message] = 'Fill correct info!'
          redirect '/films/new'
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

    get '/films/:id/edit' do
      if logged_in?
        verify_and_process_film(params[:id]) do
          erb :'films/edit'
        end
      else
        redirect '/login'
      end
    end

    patch '/films/:id' do
      if logged_in?
        verify_and_process_film(params[:id]) do
          if params[:genre] != ""
            @genre = Genre.find_or_create_by(name: params[:genre])
          else
            @genre = Genre.find_by(id: params[:genre_id])
          end
          film_title = params[:title]
          film_year = params[:year]
          film_genre_id = Genre.find_by(id: params[:genre_id])

          if @film.update(title: film_title, year: film_year, genre_id: film_genre_id.id)
            redirect "/films/#{@film.id}"
          else
            flash[:message] = 'Fill correct info!'
            redirect "/films/#{@film.id}/edit"
          end
        end
      else
        redirect '/login'
      end
    end

    delete '/films/:id' do
      if logged_in?
        verify_and_process_film(params[:id]) do
          @film.destroy
          redirect "/users/#{current_user.username}"
        end
      else
        redirect '/login'
      end
    end

  end
