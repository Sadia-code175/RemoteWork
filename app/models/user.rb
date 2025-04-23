class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

  ROLES = %w[hiring_client freelancer].freeze

  after_initialize :set_default_role, if: :new_record?

  has_one :freelancer_profile, dependent: :destroy
  has_one :hiring_client_profile, dependent: :destroy
  has_many :notifications, as: :recipient
  has_many :sent_notifications, class_name: 'Notification', as: :sender

  def profile
    if freelancer?
      freelancer_profile || build_freelancer_profile
    else
      hiring_client_profile || build_hiring_client_profile
    end
  end
  
  def freelancer?
    role == 'freelancer'
  end
  
  def hiring_client?
    role == 'hiring_client'
  end

  def unread_notifications
    notifications.unread
  end

  private

  def set_default_role
    self.role ||= 'freelancer'
  end
end


