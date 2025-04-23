class Application < ApplicationRecord
  belongs_to :job
  belongs_to :freelancer_profile
end
