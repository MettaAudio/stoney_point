class Volunteer < ActiveRecord::Base
  has_and_belongs_to_many :committees
  has_many :housing,    dependent: :destroy
  has_many :jobs
  has_many :work_days

  accepts_nested_attributes_for :committees

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def available_jobs
    committees.map { |c| c.jobs }.flatten
  end

  def full_name
    full_name = []
    full_name << first_name
    full_name << last_name
    full_name.join(' ')
  end
end
