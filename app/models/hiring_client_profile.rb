class HiringClientProfile < ApplicationRecord
  has_one_attached :company_logo  
  belongs_to :user
  has_many :jobs
  validates :user_id, uniqueness: true
end

