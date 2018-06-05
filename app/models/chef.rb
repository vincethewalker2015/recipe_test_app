class Chef < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :chefname, presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  #from chef_test 33
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }  #from chef_test 49
                    
  has_many :recipes # Use the plural as a chef has MANY recipes
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true #ref test/chefs_edit_test line 16
end