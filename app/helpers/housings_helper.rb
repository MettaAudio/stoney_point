module HousingsHelper
  def golfers_at(housing)
    return unless housing.golfers
    golfers = []
    housing.golfers.each do |golfer|
      golfers << link_to(golfer.full_name.strip, golfer)
    end
    golfers.join(', ').html_safe
  end

end
