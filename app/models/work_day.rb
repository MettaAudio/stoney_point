class WorkDay < ActiveRecord::Base
  belongs_to :job
  belongs_to :volunteer
end
