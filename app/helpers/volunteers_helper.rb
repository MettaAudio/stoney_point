module VolunteersHelper

  def primary_phone_placeholder
    @volunteer.primary_phone == nil ? '(864)' : build_phone_number(@volunteer.primary_phone)
  end

  def secondary_phone_placeholder
    @volunteer.secondary_phone == nil ? '(864)' : build_phone_number(@volunteer.secondary_phone)
  end

  def build_phone_number(ph)
    return nil if ph.blank?
    ph = ph.to_s
    "(#{ph[0,3]})#{ph[3,3]}-#{ph[6,4]}"
  end

  def golfers_for(volunteer)
    golfers = []
    return unless volunteer.housing
    volunteer.housing.each do |house|
      golfers << link_to(house.golfer.full_name, house.golfer) if house.golfer
    end
    golfers.join(', ').html_safe
  end

  def jobs_for(volunteer)
    jobs = []
    return unless volunteer.jobs
    volunteer.jobs.each do |job|
      jobs << link_to(job.title, job)
    end
    jobs.join(', ').html_safe
  end

  def housing_for(volunteer)
    houses = 0
    return '--' unless volunteer.housing.present?
    volunteer.housing.each do |house|
      houses += house.number_of_bedrooms
    end
    "#{houses} bedrooms"
  end

  def committees_for(volunteer)
    committees = []
    return unless volunteer.committees.present?
    volunteer.committees.each do |committee|
      committees << link_to(committee.name, committee)
    end
    committees.join(', ').html_safe
  end

  def shirt_sizes
    [
      'MS',
      'MM',
      'ML',
      'MXL',
      'MXXL',
      'WS',
      'WM',
      'WL',
      'WXL'
    ]
  end

  def shirt_count_for(size)
    count = 0
    Volunteer.shirts_of_size(size).each do |volunteer|
      count += (volunteer.number_of_shirts ? volunteer.number_of_shirts : 1)
    end
    count
  end

  def sessions
    ['AM', 'PM', 'Both', 'AM or PM only']
  end

  def availability
    ['Mon-Sun', 'Thur-Sun', 'Weekend Only']
  end
end
