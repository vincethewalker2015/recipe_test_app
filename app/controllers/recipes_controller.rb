class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = "Recipe was created sucessfully"
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Oops!! Something didn't go quite right here... Lets try that again!"
      render "new"
    end
  end
  
  def edit
     @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Update was sucessfull"
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Oops!! Something didn't go quite right here... Lets try that again!"
      render 'edit'
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = "Recipe has been deleted"
    redirect_to recipes_path
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
  
  
end
