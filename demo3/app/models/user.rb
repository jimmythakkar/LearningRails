class User < ActiveRecord::Base
has_many :microposts
validates :name, :length => { :maximum =>15, :minimum =>4 }
end
