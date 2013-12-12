class Organization < ActiveRecord::Base
  has_many :volunteers

  default_scope order('name ASC')
end
