module GolfersHelper

  def volunteer_housing_for(golfer)
    return unless golfer.housing
    houses = []
    golfer.housing.each do |house|
      houses << link_to(house.volunteer.full_name, house.volunteer)
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
