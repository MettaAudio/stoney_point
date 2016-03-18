class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLE_OPTIONS = ["Manage shirts", "Admin"]

  def admin?
    role == "Admin"
  end

  def manage_shirts?
    role == "Manage shirts" || admin?
  end

  def manage_committees?
    role == "Committee Manager" || admin?
  end
end
