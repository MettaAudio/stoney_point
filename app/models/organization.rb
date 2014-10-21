class Organization < ActiveRecord::Base
  has_many :volunteers
  has_many :caddies

  default_scope { order('name ASC') }
end
