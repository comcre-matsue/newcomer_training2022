class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def logged_in?
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
