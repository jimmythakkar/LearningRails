class Question < ActiveRecord::Base
belongs_to :user
has_many :answer
accepts_nested_attributes_for :answers
end
