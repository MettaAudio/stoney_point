desc 'Reset all relevant data fields'
task reset_people_data: :environment do
  volunteer_attributes = {
    waiver:           false,
    shirt_size:       nil,
    number_of_shirts: nil,
    comments:         nil,
    paid:             false,
    wednesday:        nil,
    thursday:         nil,
    friday:           nil,
    saturday:         nil,
    sunday:           nil,
    thursday_time:    nil,
    thursday_hole:    nil,
    friday_time:      nil,
    friday_hole:      nil,
    saturday_time:    nil,
    saturday_hole:    nil,
    sunday_time:      nil,
    sunday_hole:      nil,
    thursday_checkin: false,
    friday_checkin:   false,
    saturday_checkin: false,
    sunday_checkin:   false,
  }

  person_attributes = {
    is_active: false,
  }

  caddie_attributes = {
    waiver: false,
  }

  ActiveRecord::Base.transaction do
    puts "Starting with Volunteers"
    Volunteer.all.each do |volunteer|
      volunteer.update! volunteer_attributes
      print "."
    end

    puts "Successful!"
    puts "Now People"
    Person.all.each do |person|
      person.update! person_attributes
      print "."
    end

    puts "Successful!"
    puts "Now Caddies"
    Caddie.all.each do |caddie|
      caddie.update! caddie_attributes
      print "."
    end

    puts "Done!"
  end
end
