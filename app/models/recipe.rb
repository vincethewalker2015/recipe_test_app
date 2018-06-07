class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500 }
  belongs_to :chef # use chef as the singular as 1 X Chef per recipe
  validates :chef_id, presence: true # added as per test recipe_test.rb line10
  default_scope -> { order(updated_at: :desc) }
end