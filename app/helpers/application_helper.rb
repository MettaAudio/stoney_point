module ApplicationHelper
  def phone_placeholder(person)
    person.phone == nil ? '(864)' : build_phone_number(person.phone)
  end

  def nav_class(tab, path)
    return 'active' if path.match(tab)
    return 'active' if path.match("address_list") && tab == 'volunteers'
  end

  def public_controllers
    [
      "welcome_volunteers",
    ]
  end

  def hidden_form_class
    return "hidden-form-field" if !!(controller_name =~ /welcome/)
  end
end
