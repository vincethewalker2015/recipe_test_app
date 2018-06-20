class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy] #refer to line 58
  #before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy] #refer to line 62
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 4) #This will paginate the page
    #@chefs = Chef.all
  end
 
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id #This Logs the chef in once the account is created
      flash[:success] = "Hi #{@chef.chefname} You are now a Chef.."
      redirect_to chef_path(@chef)
    else
      flash[:danger] = "That didn't quite work, Try again.."
      render 'new'
    end
  end
  
  def show
    #@chef = Chef.find(params[:id]) This was all rendered under set_chef
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
   #@chef = Chef.find(params[:id]) This was all rendered under set_chef
  end
  
  def update
    #@chef = Chef.find(params[:id]) This was all rendered under set_chef
    if @chef.update(chef_params)
      flash[:success] = "Your details have been updated.."
      redirect_to chef_path(@chef)
    else
      flash.now[:danger] = "Oops! Try that again.."
      render 'edit'
    end
  end
  
  def destroy
    #@chef = Chef.find(params[:id]) This was all rendered under set_chef
    @chef.destroy
    session[:chef_id] = nil
    flash[:danger] = "Chef and all associated recipes have been deleted"
    redirect_to chefs_path
  end
  
  
  private
  
  def set_chef
    @chef = Chef.find(params[:id])
  end
  
  def require_same_user 
      if current_chef != @chef
        flash[:danger] = "You can only edit or delete your own Chef profile"
        redirect_to chefs_path
      end
  end
  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

end