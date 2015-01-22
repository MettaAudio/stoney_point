class Person < ActiveRecord::Base
  has_one :volunteer
  belongs_to :organization

  default_scope { order('last_name ASC') }
end