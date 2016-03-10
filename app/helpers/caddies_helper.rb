module CaddiesHelper

  def golfer_label
    public_facing_page? ? "Are you a golfer?" : "Do they golf?"
  end

  def caddie_experience
    public_facing_page? ? "Have you caddied before?" : "Caddie experience?"
  end

  def age
    public_facing_page? ? "What is your age?" : "Age"
  end

  def know_the_course
    public_facing_page? ? "Rate your knowledge of the golf course" : "Course?"
  end

  def know_the_rules
    public_facing_page? ? "Rate your knowlege of the rules" : "Rules?"
  end

  def caddie_waiver_text
    display_waiver? ? "I am at least 18 years of age and I accept these terms and conditions" : "Accepted waiver"
  end

end
