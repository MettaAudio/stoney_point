module CaddiesHelper

  def golfer_label
    public_facing_page? ? "Do you golf?" : "Do they golf?"
  end

  def caddie_experience
    public_facing_page? ? "Do you have experience as a caddie?" : "Caddie experience?"
  end

  def age
    public_facing_page? ? "What is your age?" : "Age"
  end

  def know_the_course
    public_facing_page? ? "Do you know the golf course?" : "Course?"
  end

  def know_the_rules
    public_facing_page? ? "Do you know the rules of golf?" : "Rules?"
  end

  def caddie_waiver_text
    display_waiver? ? "I hereby agree and attest to the above." : "Accepted waiver"
  end

end
