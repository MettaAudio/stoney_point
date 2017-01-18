class Housing < ActiveRecord::Base
  belongs_to :person
  has_and_belongs_to_many :golfers
  validates :available, presence: true
  validates :number_of_bedrooms, presence: true
  validates :number_of_bathrooms, presence: true
  validates :person_id, presence: true
  validates :max_guests, presence: true

  default_scope { joins(:person).merge(Person.order(last_name: :asc)) }
  scope :active, -> { joins(:person).where(is_active: true).merge(Person.active) }

  def self.total_number_of_beds(scope=:active)
    count = 0
    Housing.send(scope).collect { |h| count += h.max_guests.to_i }
    count
  end
end
