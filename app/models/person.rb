class Person < ActiveRecord::Base
  has_one :volunteer
  belongs_to :organization

  validates :first_name, presence: true
  validates :last_name,  presence: true

  default_scope { order('last_name ASC') }

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
end