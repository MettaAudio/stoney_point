module CaddiesHelper
  def phone_placeholder
    @caddie.phone == nil ? '(864)' : build_phone_number(@caddie.phone)
  end

end
