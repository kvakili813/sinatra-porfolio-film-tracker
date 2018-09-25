class GenresController < ApplicationController

  get '/genres/:name' do
    @genre = Genre.find_by_name(params[:name])
    if @genre.nil?
      redirect '/'
    else
      erb :'genres/show'
    end
  end
end
