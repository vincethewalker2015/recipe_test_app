class SessionsController < ApplicationController
  
  def new #for the new log-in form
    
  end
  
  def create #this will create the session
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id #stores the encripted chef_id in the session hash
      cookies.signed[:chef_id] = chef.id #added here for use with actioncable
      flash[:success] = "You have successfully logged in"
      redirect_to chef
    else
      flash.now[:danger] = "Err.. There seems to be something wrong with your log-in information. Try again.."
      render 'new'
    end
    
  end
  
  def destroy #this will log-out the session
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end