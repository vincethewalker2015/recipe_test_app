class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500 }
  validates :chef_id, presence: true # added as per test recipe_test.rb line10
  belongs_to :chef # use chef as the singular as 1 X Chef per recipe
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  default_scope -> { order(updated_at: :desc) }  #this arranges the order of the recipess from most recent down
end