class ChefsController < ApplicationController
  
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
      flash[:success] = "Hi #{@chef.chefname} You are now a Chef.."
      redirect_to chef_path(@chef)
    else
      flash[:danger] = "That didn't quite work, Try again.."
      render 'new'
    end
  end
  
  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @chef = Chef.find(params[:id])
  end
  
  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Your details have been updated.."
      redirect_to chef_path(@chef)
    else
      flash.now[:danger] = "Oops! Try that again.."
      render 'edit'
    end
  end
  
  def destroy
    @chef = Chef.find(params[:id])
    @chef.destroy
    flash[:danger] = "Chef and all associated recipes have been deleted"
    redirect_to chefs_path
  end
  
  
  private
  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

end