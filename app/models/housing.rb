class Housing < ActiveRecord::Base
  belongs_to :person
  has_and_belongs_to_many :golfers
  validates :available, presence: true
  validates :number_of_bedrooms, presence: true
  validates :number_of_bathrooms, presence: true
  validates :person_id, presence: true

  default_scope { includes(:person).order('people.last_name ASC') }
  scope :active, -> { joins(:person).where("people.is_active = ?", true) }

  def self.total_number_of_beds
    count = 0
    Housing.all.collect { |h| count += h.number_of_bedrooms.to_i }
    count
  end
end
