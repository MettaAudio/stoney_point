class Housing < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :golfer
  validates :available, presence: true
  validates :number_of_bedrooms, presence: true
  validates :number_of_bathrooms, presence: true
  validates :volunteer_id, presence: true

  default_scope includes(:volunteer).order('volunteers.last_name ASC')
end
