class User < ActiveRecord::Base

has_many :questions
has_many :answers

accepts_nested_attributes_for :questions

 attr_accessor :password
  attr_accessible :name, :email, :password
  
  validates :password, :presence     => true,
                       
                       :length       => { :within => 6..40 }

  before_save :encrypt_password

  private

    def encrypt_password
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      string # Only a temporary implementation!
    end


end





