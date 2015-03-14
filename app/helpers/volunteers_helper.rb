module VolunteersHelper

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
    golfers.join(' ').html_safe
  end

  def shifts_for(volunteer)
    shifts = []
    return unless volunteer.shifts
    volunteer.shifts.each do |shift|
      shifts << link_to(shift.time, shift)
    end
    shifts.join(' ').html_safe
  end

  def jobs_for(volunteer)
    jobs = []
    return unless volunteer.jobs
    volunteer.jobs.each do |job|
      jobs << link_to(job.title, job)
    end
    jobs.join(' ').html_safe
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
    committees.join(' ').html_safe
  end

  def mens_shirt_sizes
    [
      ["Men's Medium", "MM"],
      ["Men's Large", "ML"],
      ["Men's X-Large", "MXL"],
      ["Men's XX-Large", "MXXL"],
      ["Men's XXX-Large", "MXXXL"],
    ]
  end

  def womens_shirt_sizes
    [
      ["Women's Small", "WS"],
      ["Women's Small, Sleeveless", "WS-S"],
      ["Women's Medium", "WM"],
      ["Women's Medium, Sleeveless", "WM-S"],
      ["Women's Large", "WL"],
      ["Women's Large, Sleeveless", "WL-S"],
      ["Women's X-Large", "WXL"]
    ]
  end

  def shirt_sizes
    {
      "Men's Sizes" => mens_shirt_sizes,
      "Women's Sizes" => womens_shirt_sizes
    }
  end

  def shirt_count_for(size, volunteers)
    count = 0
    volunteers.shirts_of_size(size).each do |volunteer|
      count += (volunteer.number_of_shirts ? volunteer.number_of_shirts : 1)
    end
    count
  end

  def cap_count_for_men(volunteers)
    count = 0
    mens_shirt_sizes.each do |size|
      count += shirt_count_for(size[1], volunteers)
    end
    count
  end

  def cap_count_for_women(volunteers)
    count = 0
    womens_shirt_sizes.each do |size|
      count += shirt_count_for(size[1], volunteers)
    end
    count
  end

  def wednesday_options
    [
      "Morning",
      "Afternoon",
      "Either",
      "Both",
      "Not available",
    ]
  end

  def thursday_options
    [
      "Morning start (7-9:30)",
      "Afternoon start (11:30-2)",
      "Either",
      "Both",
      "Not available",
    ]
  end

  def friday_options
    [
      "Morning start (7-9:30)",
      "Afternoon start (11:30-2)",
      "Either",
      "Both",
      "Evening (5-8 special activity)",
      "Not available",
    ]
  end

  def saturday_options
    [
      "Early morning start (7-9:30)",
      "Late morning start (9-11:30)",
      "Either",
      "Evening (6-10 special activity)",
      "Not available",
    ]
  end

  def sunday_options
    [
      "Early morning start (7-9:30)",
      "Late morning start (9-11:30)",
      "Either",
      "Not available",
    ]
  end
end
