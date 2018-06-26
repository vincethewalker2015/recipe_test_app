require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  
  def setup
    @ingredient = Ingredient.new(name: "ingredient")
    @ingredient2 = Ingredient.new(name: "ingredient2")
  end
  
  test "ingredient should be valid" do
    assert @ingredient2.valid?
  end
  
end