class FilmsController < ApplicationController

  get '/films/new' do
    if logged_in?
      erb :'films/new'
    else
      redirect '/login'
    end
  end

  post '/films' do
    if logged_in?
      @film = Film.new(params[:new_film])
      @film.user_id = session[:user_id]
      if @film.save
        redirect "/ads/#{@film.id}"
      else
        flash[:message] = 'Fill correct info!'
        redirect '/films/new'
      end
    else
      redirect '/login'
    end
  end

  get '/films/:id' do
    @film = Ad.find_by_id(params[:id])
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
      verify_and_process_ad(params[:id]) do
        if @film.update(params[:edit_film])
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
end
