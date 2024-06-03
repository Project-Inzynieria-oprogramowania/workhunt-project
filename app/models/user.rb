class User < ApplicationRecord
    enum account_type: { person: 0, organization: 1 }
    
    has_many :emails, dependent: :destroy
    has_many :links, dependent: :destroy
    has_many :telephones, dependent: :destroy
    has_one :person, ->(user) { where(user_id: user.id) }, dependent: :destroy, foreign_key: :user_id, inverse_of: :user
    has_one :organization, ->(user) { where(user_id: user.id) }, dependent: :destroy, foreign_key: :user_id, inverse_of: :user
    has_one :avatar, as: :imageable, dependent: :destroy
    has_many :notifications, dependent: :destroy
    accepts_nested_attributes_for :person, :organization, :avatar

    attr_accessor :old_password
    has_secure_password validations: false

    validates :login, presence: true
    validate :login_complexity, if: -> { login.present? }
    validates :login, uniqueness: true, if: -> { login.present? }
    validates :password, confirmation: true, allow_blank: true, length: { minimum: 8, maximum: 32 }
    validate :password_complexity, if: -> { password.present? }
    validate :password_presence
    validate :correct_old_password, on: :update, if: -> { password.present? || login_changed? }
    
    before_validation :downcase_login

    # Create a notification for this model
    def notify(message, path_method = nil, **path_params)
        if path_method && Rails.application.routes.url_helpers.respond_to?(path_method)
            url = Rails.application.routes.url_helpers.send(path_method, path_params.merge(only_path: false, host: Rails.root))
            notifications.create(message: message, link: url)
        else
            notifications.create(message: message)
        end
    end

    private 

    def downcase_login
        self.login.downcase!
    end

    def login_complexity
        return if login =~ /\A[a-zA-Z0-9_]+\z/
        errors.add :login, 'complexity requirement not met. Login should include only digits, uppercases, lowercases and underscore'
    end

    def password_complexity
        # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
        return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*\.\-_])/
        errors.add :password, 'complexity requirement not met. Password should include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
    end

    def password_presence
        errors.add(:password, :blank) unless password_digest.present?
    end

    def correct_old_password
        return if BCrypt::Password.new(password_digest_was).is_password?(old_password)
        errors.add :old_password, 'is incorrect'
    end
end