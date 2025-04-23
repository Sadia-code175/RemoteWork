class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true
  belongs_to :sender, polymorphic: true
  
  scope :unread, -> { where(read: false) }
  
  def mark_as_read
    update(read: true)
  end
end

