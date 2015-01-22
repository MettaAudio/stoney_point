class Organization < ActiveRecord::Base
  has_many :people
  has_many :caddies

  default_scope { order('name ASC') }
end
