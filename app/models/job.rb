class Job < ApplicationRecord
  belongs_to :hiring_client_profile
  has_many :applications
  has_many :freelancer_profiles, through: :applications
end