class PersonForm < FormBuilder

  attr_reader :form_params,
              :page_params,
              :person,
              :volunteer,
              :golfer,
              :caddie

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
            :sessions,
            :availability,
            :golfer,
            :physical_activity,
            :waiver,
            :paid,
            to: :volunteer, prefix: true, allow_nil: true

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
    @person           = find_person
    @volunteer        = find_volunteer
    @caddie           = find_caddie
    @golfer           = find_golfer
  end

  def update
    update_person && update_volunteer && update_caddie && update_golfer
  end

  def update_person
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
    volunteer.number_of_shirts  = @volunteer_params[:number_of_shirts]
    volunteer.comments          = @volunteer_params[:comments]
    volunteer.sessions          = @volunteer_params[:sessions]
    volunteer.availability      = @volunteer_params[:availability]
    volunteer.golfer            = @volunteer_params[:golfer]
    volunteer.physical_activity = @volunteer_params[:physical_activity]
    volunteer.waiver            = @volunteer_params[:waiver]
    volunteer.paid              = @volunteer_params[:paid]
    volunteer.person            = person

    volunteer.save
  end

  def update_caddie
    return true unless @caddie_params.present?
    caddie.golf     = @caddie_params[:golf]
    caddie.course   = @caddie_params[:course]
    caddie.rules    = @caddie_params[:rules]
    caddie.comments = @caddie_params[:comments]

    caddie.save
  end

  def update_golfer
    return true unless @golfer_params.present?
    golfer.caddie_preferences = @golfer_params[:caddie_preferences]

    golfer.save
  end

  def find_person
    @_person ||= begin
      page_params[:id] ? Person.find(page_params[:id]) : Person.new
    end
  end

  def find_volunteer
    @_volunteer ||= begin
      person.volunteer || Volunteer.new
    end
  end

  def find_caddie
    @_caddie ||= begin
      person.caddie || Caddie.new
    end
  end

  def find_golfer
    @_golfer ||= begin
      person.golfer || Golfer.new
    end
  end
end