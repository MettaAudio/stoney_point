module CaddiesHelper
  def phone_placeholder
    @caddie.phone == nil ? '(864)' : build_phone_number(@caddie.phone)
  end

  def courses_list
    ['Excel', 'Good', 'None']
  end

  def rules_list
    ['Excel', 'Good', 'Fair']
  end

end
