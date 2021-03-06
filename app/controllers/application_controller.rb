require './config/environment'
class ApplicationController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  configure do
    enable :sessions
    set :session_secret, 'film tracker'
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/' do
    erb :index
  end

  helpers do
#redirect to /login not logged_in
#
    def redirect_if_not_logged_in # start here
      if !logged_in?
        redirect '/login'
      end
    end

     def logged_in?
      !!session[:user_id]
    end

     def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def verify_and_process_film(id)
      @film = Film.find_by_id(id)
        if @film.nil?
          redirect '/'
        else
          if current_user.films.include?(@film)
            yield
          else
            redirect '/'
          end
        end
      end

    end

  end
