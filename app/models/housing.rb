class Housing < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :golfer
  validates :available, presence: true
  validates :number_of_bedrooms, presence: true
  validates :number_of_bathrooms, presence: true
  validates :volunteer_id, presence: true

  default_scope includes(:volunteer).order('volunteers.last_name ASC')

  def self.total_number_of_beds
    count = 0
    Housing.all.collect { |h| count += h.number_of_bedrooms.to_i }
    count
  end
end
