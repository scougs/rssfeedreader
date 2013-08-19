class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
   redirect_to root_url , alert: "You can't access this page"
  end

  protected
  def after_sign_in_path_for(resource)
    feeds_path
  end
end
