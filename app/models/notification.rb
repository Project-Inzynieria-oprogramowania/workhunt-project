class Notification < ApplicationRecord
    belongs_to :user

    validates :message, presence: true

    after_commit :broadcast_notification, on: :create

    private

    def broadcast_notification
        ActionCable.server.broadcast "notifications:#{self.user.id}", {
            id: self.id,
            message: self.message,
            link: self.link,
            read: self.read
        }
    end
end