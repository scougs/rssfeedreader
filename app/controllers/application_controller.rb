class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def after_sign_in_path_for(resource)
    feeds_path
  end

# below method requires a 'user edit' path and page set up to word - have left method as a reminder

  # def after_new_user_registration_path_for(resource)
  #   edit_user_path
  # end
end
