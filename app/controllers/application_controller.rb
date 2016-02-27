class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :permit_only_admin

  private
  def permit_only_admin
    # raise ActionController::RoutingError.new('Not Found') unless current_user.admin?
  end
end
