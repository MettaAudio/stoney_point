class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :permit_only_admin
  before_filter :authenticate_user!
  helper_method :xeditable?

  def xeditable?(object=nil)
    true
  end

  private
  def permit_only_admin
    return true if controller_path.include?('devise')
    raise ActionController::RoutingError.new('Not Found') unless current_user.try(:admin?) || current_user.try(:super_user?)
  end
end
