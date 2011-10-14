require 'digest'
class User < ActiveRecord::Base

  has_many :questions
  has_many :answers

  accepts_nested_attributes_for :questions

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


   attr_accessor :password
    attr_accessible :name, :email, :password
  
    validates :password, :presence     => true,
                       
                       :length       => { :within => 6..40 }

    before_save :encrypt_password
     

    # Compare encrypted_password with the encrypted version of
    # submitted_password.

    def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
    end
   
   def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
   end

   def self.authenticate_with_salt(id, cookie_salt)  #firsts finds the user by unique id, and then verifies that the salt  								stored in the cookie is the correct one for that user.
     user = find_by_id(id)
     (user && user.salt == cookie_salt) ? user : nil
   end

	
  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
      
end





