class Shift < ActiveRecord::Base
  has_many :volunteers

  default_scope { order('time ASC') }
end
