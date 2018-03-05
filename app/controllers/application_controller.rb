class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def authenticate_user!
    unless user_signed_in?
      store_location_for(:user, request.url)
      redirect_to root_url
    end
  end

  def user_not_authorized
    flash[:alert] = I18n.t('app.unauthorized')
    redirect_to(request.referrer || root_path)
  end

  def after_sign_in_path_for(resource)
    profile_user_path(resource)
  end
end
