class Volunteer < ActiveRecord::Base
  has_and_belongs_to_many :committees
  has_many :housing,    dependent: :destroy

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def full_name
    full_name = []
    full_name << first_name
    full_name << last_name
    full_name.join(' ')
  end
end
