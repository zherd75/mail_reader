class ApplicationController < ActionController::Base
  before_action :require_login, except: [:new, :create]
  protect_from_forgery with: :exception

  private

  def logged_in?
    session[:id] ? true : false
  end

  def require_login
    unless logged_in?
      redirect_to new_login_url
    end
  end
end