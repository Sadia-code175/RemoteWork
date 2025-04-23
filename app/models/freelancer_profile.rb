class FreelancerProfile < ApplicationRecord
  has_one_attached :cv_file 
  belongs_to :user
  has_many :applications
  has_many :jobs, through: :applications
  validates :user_id, uniqueness: true
end

