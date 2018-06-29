class IngredientsController < ApplicationController
   before_action :set_ingredient, only: [:show, :edit, :update]
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if  @ingredient.save
     flash[:success] = "Ingredient has been added.."
     redirect_to ingredient_path(@ingredient)
   else
     flash.now[:danger] = "Oops! Give that another try.."
     render "new"
    end
  end
  
  def edit
    
  end
  
  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingredient was sucessfully updated"
      redirect_to ingredient_path(@ingredient)
    else
      flash.now[:danger] = "Something went Wrong! Try it again.."
      render "edit"
    end
  end
  
  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end
  
  private
  
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
  
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
  
end