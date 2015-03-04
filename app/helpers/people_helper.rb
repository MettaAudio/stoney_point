module PeopleHelper
  def volunteer_link(person)
    person.volunteer ? link_to(edit_welcome_volunteer_url(person), edit_welcome_volunteer_url(person)) : ""

  end

  def housing_link(person)
    "url for edit or new housing"
  end

  def caddie_link(person)
    "url for edit or new caddie"
  end
end
