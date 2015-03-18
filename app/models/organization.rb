class Organization < ActiveRecord::Base
  has_many :people
  has_many :caddies

  default_scope { order('name ASC') }
  SCHOOL = 'College'

  def self.college_organization_id
    find_by_name(SCHOOL).try(:id)
  end
end
