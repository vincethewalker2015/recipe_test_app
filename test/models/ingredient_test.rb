require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  
  def setup
    @ingredient = Ingredient.new(name: "ingredient")
    @ingredient2 = Ingredient.new(name: "ingredient2")
  end
  
  test "ingredient should be valid" do
    assert @ingredient2.valid?
  end
  
  test "ingredient name should be present" do
    @ingredient.name = ""
    assert_not @ingredient.valid?
  end
  
  test "ingredient name should not be less than 3 characters" do
    @ingredient.name = "a" * 2
    assert_not @ingredient.valid?
  end
  
  test "ingredient name shoulden't be more than 25 characters"  do
    @ingredient.name = "a" * 26
    assert_not @ingredient.valid?
  end
end