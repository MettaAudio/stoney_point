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