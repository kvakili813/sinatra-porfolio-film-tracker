require './config/environment'
require "rack-flash"

class ApplicationController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'film tracker'
    use Rack::Flash
   end

  get '/' do
    erb :index
  end

  helpers do
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
