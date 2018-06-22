require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "vincent@example.com",
                         password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "vincent2", email: "vincent2@example.com",
                              password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "vincent3", email: "vincent3@example.com",
                          password: "password", password_confirmation: "password", admin: true)
                          
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
  
  test "accept a valid edit" do
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
  
   #Tests below createted to tesst Admin functionality
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: {chefname: "vincethewalker", email: "vincethewalker@example.com" }} #These names I want to edit to in the test must match both the "assert_match" below
    assert_redirected_to @chef  # This is another way of pointing to - "chefs/show"
    assert_not flash.empty?
    @chef.reload # need to reload @chef instance variable, once reloaded must match line 26, see below:
    assert_match "vincethewalker", @chef.chefname #must match patch chef_path name
    assert_match "vincethewalker@example.com", @chef.email #must match patch chef_path email
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "vinnie"
    updated_email = "vinnie@example.com"
    patch chef_path(@chef), params: { chef: {chefname: updated_name, email: updated_email }}
    assert_redirected_to chefs_path  # Ref chefs_controller line65 equire_same_user = requires: chefs_path
    assert_not flash.empty?
    @chef.reload # nned to reload @chef instance variable, once reloaded must match line 26, see below:
    assert_match "mashrur", @chef.chefname #as per @chef details
    assert_match "vincent@example.com", @chef.email #as per @chef details
  end
end
