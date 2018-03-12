class SupportMessage < ApplicationRecord
  validates :email, :body, presence: true
  validates :email, format: { with: Devise.email_regexp }
end
