class Caddie < ActiveRecord::Base
  belongs_to :golfer

  def full_name
    [first_name, last_name].join(' ')
  end

  def phone=(val)
    write_attribute(:phone, formatted_number(val))
  end

  def formatted_number(val)
    val.gsub(/\D/, '')
  end
end
