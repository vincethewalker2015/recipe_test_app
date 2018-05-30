require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "vincent@example.com")
    @recipe = Recipe.create(name: "Vegetable sauce", description: "great vegetable sautee, add vegetable and oil", chef: @chef)
  end
  
  test "Sucessfully delete a recipe" do
    get recipe_path(@recipe)
    assert_template "recipes/show"
    assert_select "a[href=?]", recipe_path(@recipe), method: :delete, text: "Delete This Recipe"
    assert_difference "Recipe.count", -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end
