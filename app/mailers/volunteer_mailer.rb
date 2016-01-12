class VolunteerMailer < ActionMailer::Base
  default from: "stoneypointhousing@gmail.com"

  def not_found(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
    mail(to: 'stoneypointvolunteer@gmail.com', bcc: 'john@mettaaudio.com', subject: "User not found: #{first_name} #{last_name}")
  end
end
