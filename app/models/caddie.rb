class Caddie < ActiveRecord::Base
  belongs_to :golfer
  belongs_to :organization

  scope :active, -> { where(:is_active => true) }

  def full_name
    [first_name, last_name].join(' ')
  end

  def phone=(val)
    write_attribute(:phone, formatted_number(val))
  end

  def formatted_number(val)
    return val if val == nil
    val == '(864)' ? nil : val.gsub(/\D/, '')
  end
end
