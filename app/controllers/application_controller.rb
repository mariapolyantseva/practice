class ApplicationController < ActionController::Base
	def after_sign_in_path_for(user) # resource was as paramentr 
		user_path(user)	
  	end

  	def after_sign_out_path_for(resource) # resource was as paramentr
  		new_user_session_path
  	end
end
 