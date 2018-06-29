require 'test_helper'

class IngredientsTest < ActionDispatch::IntegrationTest
  
   def setup
    @chef = Chef.create!(chefname: "mashrur", email: "vincent@example.com",
                          password: "password", password_confirmation: "password")
    @ingredent = Ingredient.create(name: "tomatoes")
    #@ingredient2 = @chef.ingredients.build(name: "mushrooms")
    #@ingredient2.save
   end
   
   test "should get ingredients index" do
     get ingredients_url
     assert_response :success
   end
   
    test "should get ingredients listing" do
    get ingredients_path
    assert_template 'ingredients/index'
    #assert_match @recipe.name, response.body - No longer valid as we are testing for links as well!!
    assert_select "a[href=?]", ingredients_path(@ingredient), text: @ingredient
    #assert_match @recipe2.name, response.body
    #assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

   
end