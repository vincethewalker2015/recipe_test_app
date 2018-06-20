require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "vincent@example.com",
                         password: "password", password_confirmation: "password")
  end
  
   test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
      #patch chef_path(@chef), params: { chef: {chefname: " ", email: " ", password: "password",
                                 # password_confirmation: "password confirmation" }}
      patch chef_path(@chef), params: { chef: {chefname: " ", email: " " }}
      #Although This above test wil not require a password test, you will still get an error when you run rails test
      #To resolve go to models/chef.rb line11 validates :password.. at the end add "allow_nil: true"
    assert_template "chefs/edit"
    assert_select "h2.panel-title" #These are both error messages..
    #assert_select "div.panel.body"
  end
  
  test "accept a valid signup" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: {chefname: "vincent1", email: "vincent1@example.com" }}
    assert_redirected_to @chef  # This is another way of pointing to - "chefs/show"
    assert_not flash.empty?
    @chef.reload # nned to reload @chef instance variable, once reloaded must match line 26, see below:
    assert_match "vincent1", @chef.chefname
    assert_match "vincent1@example.com", @chef.email
  end
end
