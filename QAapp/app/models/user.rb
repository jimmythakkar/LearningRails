class User < ActiveRecord::Base

has_many :questions
has_many :answers

accepts_nested_attributes_for :questions
end





