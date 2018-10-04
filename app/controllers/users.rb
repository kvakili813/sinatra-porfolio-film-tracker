class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :'user/signup'
    end
  end

  post '/signup' do
    @new_user = User.new(username: params[:username].downcase, password: params[:password])

    if params[:username].match(/^[a-zA-Z0-9_-]*$/) == nil
      flash[:message] = 'Only letters, numbers, underscore(_) and hyphen(-) are allowed for Username!'
      redirect '/signup'
    elsif @new_user.save
     session[:user_id] = @new_user.id
     redirect '/'
   else
     flash[:message] = 'Fill all the fields'
     redirect '/signup'
   end
 end



end
