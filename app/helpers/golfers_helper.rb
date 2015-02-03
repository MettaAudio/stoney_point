module GolfersHelper

  def volunteer_housing_for(golfer)
    return unless golfer.housings
    houses = []
    golfer.housings.each do |house|
      houses << link_to(house.person.full_name, house.person.volunteer)
    end
    houses.join(', ').html_safe
  end

  def caddies_for(golfer)
    return unless golfer.caddies.present?
    caddies = []
    golfer.caddies.each do |caddie|
      caddies << link_to(caddie.full_name, caddie)
    end
    caddies.join(', ').html_safe
  end
end
