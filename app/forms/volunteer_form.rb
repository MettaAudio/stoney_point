class VolunteerForm < FormBuilder

  attr_reader :form_params,
              :page_params,
              :person,
              :volunteer,
              :first_name,
              :last_name,
              :street,
              :city,
              :state,
              :zip,
              :phone,
              :email,
              :waiver,
              :is_active,
              :shirt_size,
              :number_of_shirts,
              :paid,
              :physical_activity,
              :golfer,
              :availability,
              :sessions,
              :comments,
              :id

  def initialize(args={})
    @page_params = args[:page_params] || {}
    @form_params = args[:form_params] || {}
    @volunteer   = find_volunteer
    @person      = find_person
    create_volunteer_methods
    create_person_methods
  end

  def save
    # if valid?
      return create_or_update_person == true && create_or_update_volunteer == true
    # elsif
    #   false
    # end
  end

  def find_volunteer
    @_volunteer ||= begin
      page_params[:id] ? Volunteer.find(page_params[:id]) : Volunteer.new
    end
  end

  def find_person
    @_person ||= begin
      volunteer.person || volunteer.person = Person.new
    end
  end

  def person_attributes
    [
      :first_name,
      :last_name,
      :email,
      :street,
      :city,
      :state,
      :zip,
      :phone,
      :organization_id,
      :is_active
    ]
  end

  def create_person_methods
    person_attributes.each do |method|
      self.class.send(:define_method, method) do
        return form_params[method] unless form_params.blank?
        person.try(method)
      end
    end
  end

  def volunteer_attributes
    [
      :shirt_size,
      :number_of_shirts,
      :comments,
      :sessions,
      :availability,
      :golfer,
      :physical_activity,
      :waiver,
      :paid
    ]
  end

  def create_volunteer_methods
    (volunteer_attributes + [:id]).each do |method|
      self.class.send(:define_method, method) do
        return form_params[method] unless form_params.blank?
        volunteer.try(method)
      end
    end
  end

  private
  def create_or_update_person
    @_updated_person ||= begin
      params = {}
      person_attributes.each do |attribute|
        params[attribute] = form_params[attribute]
      end

      person.update_attributes(params)
    end

    @_updated_person
  end

  def create_or_update_volunteer
    @_updated_volunteer ||= begin
      params = {}
      volunteer_attributes.each do |attribute|
        params[attribute] = form_params[attribute]
      end

      volunteer.update_attributes(params)
    end

    @_updated_volunteer
  end

end