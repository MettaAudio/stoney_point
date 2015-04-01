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

  def add_link(path)
    link_to("<span class='glyphicon glyphicon-plus-sign'></span>".html_safe, path, class: 'add_link')
  end

  def existing_link(object)
    html = ""
    html += link_to("<span class='glyphicon glyphicon-ok'></span>".html_safe, object)
    html += " "
    html += link_to("<span class='glyphicon glyphicon-trash'></span>".html_safe, object, class: 'delete_link', method: :delete, data: { confirm: 'Are you sure?' })

    html.html_safe
  end
end
