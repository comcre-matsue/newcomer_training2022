class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def logged_in?
    @current_user ||= User.find_by(id: session[:user_id])
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
