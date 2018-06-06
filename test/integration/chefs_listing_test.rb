require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  
  def setup
     @chef = Chef.create!(chefname: "vincent", email: "vincent@example.com",
                          password: "password", password_confirmation: "password")
     @chef2 = Chef.create!(chefname: "vincent2", email: "vincent2@example.com",
                          password: "password", password_confirmation: "password")
  end
  
  test "Should get chefs index" do 
    get chefs_url
    assert_response :success
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
    
    
  end
  
  
end
