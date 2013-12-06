module VolunteersHelper

  def primary_phone_placeholder
    @volunteer.primary_phone == nil ? '(864)' : build_phone_number(@volunteer.primary_phone)
  end

  def secondary_phone_placeholder
    @volunteer.secondary_phone == nil ? '(864)' : build_phone_number(@volunteer.secondary_phone)
  end

  def build_phone_number(ph)
    ph = ph.to_s
    "(#{ph[0,3]})#{ph[3,3]}-#{ph[6,4]}"
  end
end
