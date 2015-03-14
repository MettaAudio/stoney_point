class PersonForm < FormBuilder

  attr_reader :form_params,
              :page_params,
              :person,
              :volunteer,
              :golfer,
              :caddie,
              :housing

  delegate  :first_name,
            :last_name,
            :email,
            :street,
            :city,
            :state,
            :zip,
            :phone,
            :organization_id,
            :is_active,
            to: :person, prefix: true, allow_nil: true

  delegate  :shirt_size,
            :number_of_shirts,
            :comments,
            :golfer,
            :physical_activity,
            :waiver,
            :paid,
            :uniform_price,
            :wednesday,
            :thursday,
            :friday,
            :saturday,
            :sunday,
            to: :volunteer, prefix: true, allow_nil: true

  delegate  :available,
            :number_of_bedrooms,
            :number_of_bathrooms,
            :pets,
            :smoking,
            :comments,
            to: :housing, prefix: true, allow_nil: true

  delegate  :golf,
            :course,
            :rules,
            :comments,
            to: :caddie, prefix: true, allow_nil: true

  delegate  :caddie_preferences,
            to: :golfer, prefix: true, allow_nil: true

  def initialize(args={})
    @page_params      = args[:page_params] || {}
    @person_params    = @page_params[:person_form] || {}
    @volunteer_params = @person_params[:volunteer]
    @caddie_params    = @person_params[:caddie]
    @golfer_params    = @person_params[:golfer]
    @housing_params   = @page_params[:housing] || @person_params[:housing]

    @person           = args[:person]    || Person.new
    @volunteer        = args[:volunteer] || Volunteer.new
    @caddie           = args[:caddie]    || Caddie.new
    @golfer           = args[:golfer]    || Golfer.new
    @housing          = args[:housing]   || Housing.new
  end

  def update
    update_person && update_volunteer && update_caddie && update_golfer && update_housing
  end

  def update_person
    return true unless @person_params.present?
    person.first_name      = @person_params[:person_first_name]
    person.last_name       = @person_params[:person_last_name]
    person.email           = @person_params[:person_email]
    person.street          = @person_params[:person_street]
    person.city            = @person_params[:person_city]
    person.state           = @person_params[:person_state]
    person.zip             = @person_params[:person_zip]
    person.phone           = @person_params[:person_phone]
    person.organization_id = @person_params[:person_organization_id]
    person.is_active       = @person_params[:person_is_active]

    person.save
  end

  def update_volunteer
    return true unless @volunteer_params.present?
    volunteer.shirt_size        = @volunteer_params[:shirt_size]
    volunteer.number_of_shirts  = @volunteer_params[:number_of_shirts] || 1
    volunteer.comments          = @volunteer_params[:comments]
    volunteer.golfer            = @volunteer_params[:golfer]
    volunteer.physical_activity = @volunteer_params[:physical_activity]
    volunteer.waiver            = @volunteer_params[:waiver]
    volunteer.paid              = @volunteer_params[:paid]
    volunteer.uniform_price     = @volunteer_params[:uniform_price]
    volunteer.wednesday         = @volunteer_params[:wednesday]
    volunteer.thursday          = @volunteer_params[:thursday]
    volunteer.friday            = @volunteer_params[:friday]
    volunteer.saturday          = @volunteer_params[:saturday]
    volunteer.sunday            = @volunteer_params[:sunday]
    volunteer.person            = person

    volunteer.save
  end

  def update_caddie
    return true unless @caddie_params.present?
    caddie.golf            = @caddie_params[:golf]
    caddie.course          = @caddie_params[:course]
    caddie.rules           = @caddie_params[:rules]
    caddie.comments        = @caddie_params[:comments]
    caddie.person          = person

    caddie.save
  end

  def update_housing
    return true unless @housing_params.present?
    housing.available           = @housing_params[:available]
    housing.number_of_bedrooms  = @housing_params[:number_of_bedrooms]
    housing.number_of_bathrooms = @housing_params[:number_of_bathrooms]
    housing.pets                = @housing_params[:pets]
    housing.smoking             = @housing_params[:smoking]
    housing.comments            = @housing_params[:comments]
    housing.golfer_ids          = @housing_params[:golfer_ids]
    housing.person              = person

    housing.save
  end

  def update_golfer
    return true unless @golfer_params.present?
    golfer.caddie_preferences = @golfer_params[:caddie_preferences]
    golfer.caddie_ids         = @golfer_params[:caddie_ids]
    golfer.person             = person

    golfer.save
  end
end