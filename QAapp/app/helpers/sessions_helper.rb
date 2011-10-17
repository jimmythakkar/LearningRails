module SessionsHelper

  def sign_in(user)
   cookies.permanent.signed[:remember_token] = [user_id,user.salt] #remember token is a cookie which is placed on user's      									    browser                   
   self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end
	  

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)      #?
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
 




                           #it simply defines a method current_user= expressly designed to handle assignment to               				    current_user.The method body just sets an instance variable @current_user and thus effectively 				    storing the user for later. 
