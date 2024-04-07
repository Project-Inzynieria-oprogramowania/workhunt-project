class User < ApplicationRecord
    enum account_type: { person: 0, organization: 1 }
    
    has_one :person, -> { where(user_type: 'person') }, dependent: :destroy, foreign_key: :user_id, inverse_of: :user
    has_one :organization, -> { where(user_type: 'organization') }, dependent: :destroy, foreign_key: :user_id, inverse_of: :user

    attr_accessor :old_password
    has_secure_password validations: false

    validates :login, presence: true, uniqueness: true
    validates :password, confirmation: true, allow_blank: true, length: {minimum: 8, maximum: 32}
    validate :password_complexity
    validate :password_presence
    validate :correct_old_password, on: :update
    before_save :downcase_login
    
    private 

    def downcase_login
        login.downcase!
    end

    def password_complexity
        return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/
        errors.add :password, 'complexity requirement not met. Password should include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
    end

    def password_presence
        errors.add(:password, :blank) unless password_digest.present?
    end

    def correct_old_password
        return unless password_digest_changed? && !old_password.blank?
        return if BCrypt::Password.new(password_digest_was).is_password?(old_password) && !old_password.blank?
        errors.add :old_password, 'is incorrect'
    end
end