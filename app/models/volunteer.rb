class Volunteer < ActiveRecord::Base
  has_and_belongs_to_many :committees
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :shifts
  belongs_to :organization
  belongs_to :person
  has_many :work_days

  after_initialize :init

  UNIFORM_PRICE = 35

  accepts_nested_attributes_for :committees

  delegate  :first_name,
            :last_name,
            :full_name,
            :street,
            :city,
            :state,
            :zip,
            :phone,
            :email,
            :is_active,
            :organization,
            :organization_id,
            to: :person

  scope :active, -> { joins(:person).where("people.is_active = ?", true) }
  scope :with_committees, -> { joins(:committees) }
  scope :with_scheduleable_committees, -> { joins(:committees).merge(Committee.scheduleable) }
  scope :receiving_shirts, -> { where("number_of_shirts > 0 AND number_of_shirts IS NOT NULL") }
  scope :shirts_of_size, ->(shirt) { where("shirt_size = ? ", shirt) }
  scope :shirts_without_size, -> { where("shirt_size IS NULL OR shirt_size = ''").merge(Volunteer.receiving_shirts) }
  scope :with_shirts_paid, -> { where(paid: true) }
  scope :with_shirts_unpaid, -> { where(paid: [false, nil]) }
  scope :schedule_for, ->(day) { where("#{day}_time IS NOT NULL") }

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

  def self.total_receipts
    receiving_shirts.with_shirts_paid.collect{ |v| (v.number_of_shirts * v.uniform_price)}.inject(:+) || 0
  end

  def self.time_options
    time_options = []
    minute_intervals = ['00', '15', '30', '45']
    ['AM', 'PM'].each do |meridiem|
      if meridiem == 'AM'
        [7,8,9,10,11].each do |hour|
          minute_intervals.each do |minute|
            time_options << "#{hour}:#{minute} #{meridiem}"
          end
        end
      elsif meridiem == 'PM'
        [12,1,2,3,4,5,6].each do |hour|
          minute_intervals.each do |minute|
            time_options << "#{hour}:#{minute} #{meridiem}"
          end
        end
      end
    end
    time_options
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
      "wednesday",
      "thursday",
      "friday",
      "saturday",
      "sunday",
    ]
  end

  private
  def init
    self.number_of_shirts  ||= 0
    self.uniform_price     ||= UNIFORM_PRICE
  end
end
