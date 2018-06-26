require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    #@comment = Comment.new(description: "description")
    #@comment2 = Comment.new(description: "description2")
    @chef = Chef.create!(chefname: "vincent", email: "vince@example.com",
                         password: "password", password_confirmation: "password")
    @comment = @chef.comments.build(description: "description")
  end
  
  test "comment without chef should be invalid" do
    @comment.chef_id = nil
    assert_not @comment.valid? 
  end
  
  test "a comment description should be present" do
    @comment.description = ""
    assert_not @comment.valid?
  end
  
  test "ingredient name should not be less than 3 characters" do
    @comment.description = "a" * 3
    assert_not @comment.valid?
  end
  
  test "ingredient name shoulden't be more than 25 characters"  do
    @comment.description = "a" * 141
    assert_not @comment.valid?
  end
end