class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ADMIN_ROLE               = "Admin"
  SHIRT_MANAGER            = "Manage shirts"
  COMMITTEE_MANAGER        = "Committee Manager"
  HOUSING_MANAGER          = "Housing Manager"
  VOLUNTEER_CENTER_MANAGER = "Volunteer Center Manager"

  ROLE_OPTIONS = [SHIRT_MANAGER, ADMIN_ROLE, COMMITTEE_MANAGER, HOUSING_MANAGER, VOLUNTEER_CENTER_MANAGER, 'No Role']

  def self.role_options
    ROLE_OPTIONS + Committee.scheduleable.collect { |c| "#{c.name.titlecase} Manager"}
  end

  def super_user?
    ['john@mettaaudio.com', 'ctomking@gmail.com'].include? email.to_s.downcase
  end

  def admin?
    role == ADMIN_ROLE
  end

  def manage_shirts?
    role == SHIRT_MANAGER || admin?
  end

  def manage_committees?
    role == COMMITTEE_MANAGER || admin?
  end

  def volunteer_center_manager?
    role == VOLUNTEER_CENTER_MANAGER || admin?
  end

  def housing_manager?
    role == HOUSING_MANAGER || admin?
  end
end
