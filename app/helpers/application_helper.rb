module ApplicationHelper
  def phone_placeholder(person)
    person.phone == nil ? '(864)' : build_phone_number(person.phone)
  end
end
