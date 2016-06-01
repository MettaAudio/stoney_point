class Person < ActiveRecord::Base
  require 'csv'
  has_one :volunteer, dependent: :destroy
  has_one :caddie, dependent: :destroy
  has_one :golfer, dependent: :destroy
  has_many :housings, dependent: :destroy
  belongs_to :organization

  validates :first_name, presence: true
  validates :last_name,  presence: true

  after_initialize :init

  default_scope { order('last_name ASC') }
  scope :active, -> { where(is_active: true) }
  scope :volunteers, -> { joins(:volunteer) }
  scope :housing, -> { joins(:housings) }
  scope :caddies, -> { joins(:caddie) }

   def self.to_csv(scope)
    column_names = [
      "first_name",
      "last_name",
      "street",
      "city",
      "state",
      "zip",
    ]

    CSV.generate do |csv|
      csv << column_names
      self.active.send(scope).each do |person|
        csv << person.attributes.values_at(*column_names)
      end
    end
  end

  def phone=(val)
    write_attribute(:phone, formatted_number(val))
  end

  def formatted_number(val)
    return val if val == nil || val.is_a?(Integer)
    val == '(864)' ? nil : val.gsub(/\D/, '')
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def init
    self.is_active = true if (self.has_attribute? :is_active) && self.is_active.nil?
  end
end
