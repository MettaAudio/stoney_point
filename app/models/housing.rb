class Housing < ActiveRecord::Base
  belongs_to :volunteer
  validates :available, presence: true
end
