class Volunteer < ActiveRecord::Base
  has_and_belongs_to_many :committees
  has_many :housing,    dependent: :destroy
  has_many :jobs
  has_many :work_days

  accepts_nested_attributes_for :committees

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def primary_phone=(val)
    write_attribute(:primary_phone, formatted_number(val))
  end

  def secondary_phone=(val)
    write_attribute(:secondary_phone, formatted_number(val))
  end

  def formatted_number(val)
    val == '(864)' ? nil : val.gsub(/\D/, '')
  end

  def available_jobs
    available_jobs = []
    available_jobs << self.jobs
    available_jobs << committees.map { |c| c.jobs }
    available_jobs.flatten
  end

  def full_name
    full_name = []
    full_name << first_name
    full_name << last_name
    full_name.join(' ')
  end
end
