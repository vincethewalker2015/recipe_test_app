require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "vincent@example.com")
    @recipe = Recipe.create(name: "Vegetable sauce", description: "great vegetable sautee, add vegetable and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken saute", description: "great chicken dish")
    @recipe2.save
  end
  
  test "Should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    #assert_match @recipe.name, response.body - No longer valid as we are testing for links as well!!
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    #assert_match @recipe2.name, response.body
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
  
  test "Should get to recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end
  
  
end
