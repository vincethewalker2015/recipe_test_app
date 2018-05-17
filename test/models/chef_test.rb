require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup 
    @chef = Chef.new(chefname: "John", email: "chef@address.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do
    @chef.chefname = "a" * 21
    assert_not @chef.valid?
  end
  
  test "email should not be too long" do
    @chef.email = "a" * 255
    assert_not @chef.valid?
  end
  
  test "email address should accept valid format" do #look at chef.rb line4 and line6 for solution
    valid_emails = %w[user@example.com VINCENT@gmail.com J.Walker@yahoo.ca paul+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid addresses" do
    invalid_emails = %w[vinny@example vinny@example,com vinny.name@gmail. vinny@bar+foo.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case insensitive" do #look at chef.rb line7 for solution
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "email should be lower case before hitting db" do  #look at chef.rb line2 for solution
   mixed_email = "JohN@Example.com"
   @chef.email = mixed_email
   @chef.save
   assert_equal mixed_email.downcase, @chef.reload.email
  end
  
  
end