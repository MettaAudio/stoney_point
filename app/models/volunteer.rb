class Volunteer < ActiveRecord::Base
  has_and_belongs_to_many :committees
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :shifts
  belongs_to :organization
  has_many :housing,    dependent: :destroy
  has_many :work_days

  accepts_nested_attributes_for :committees

  validates :first_name, presence: true
  validates :last_name,  presence: true

  default_scope { order('last_name ASC') }

  scope :with_committees, -> { joins(:committees) }
  scope :receiving_shirts, -> { where("shirt_size <> ''") }
  scope :shirts_of_size, ->(shirt) { where("shirt_size = ? ", shirt) }
  scope :with_shirts_paid, -> { where('paid = ?', true)}
  scope :with_shirts_unpaid, -> { where('paid = ?', false)}

  def self.working
    Volunteer.with_committees.distinct
  end

  def self.number_of_shirts_paid
    count = 0
    receiving_shirts.with_shirts_paid.each do |shirt|
      count += shirt.number_of_shirts ? shirt.number_of_shirts : 1
    end
    count
  end

  def self.number_of_shirts_unpaid
    count = 0
    receiving_shirts.with_shirts_unpaid.each do |shirt|
      count += shirt.number_of_shirts ? shirt.number_of_shirts : 1
    end
    count
  end

  def self.number_of_shirts_unknown
    count = 0
    shirts_of_size('?').each do |shirt|
      count += shirt.number_of_shirts ? shirt.number_of_shirts : 1
    end
    count
  end

  def primary_phone=(val)
    write_attribute(:primary_phone, formatted_number(val))
  end

  def secondary_phone=(val)
    write_attribute(:secondary_phone, formatted_number(val))
  end

  def formatted_number(val)
    return val if val == nil
    val == '(864)' ? nil : val.gsub(/\D/, '')
  end

  def duplicate!
    duplicate_attributes = {}
    usable_attributes.each do |usable_attribute|
      duplicate_attributes[usable_attribute] = self.send(usable_attribute)
    end
    duplicate_attributes["first_name"] = '** Duplicate **'

    new_volunteer = Volunteer.create!(duplicate_attributes)
    new_volunteer
  end

  def usable_attributes
    [
      "street",
      "last_name",
      "city",
      "state",
      "zip",
      "primary_phone",
      "secondary_phone",
      "email",
      "organization_id",
      "paid",
      "availability",
      "sessions"
    ]
  end

  def full_name
    full_name = []
    full_name << first_name
    full_name << last_name
    full_name.join(' ')
  end
end
