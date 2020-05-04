class Phone < ApplicationRecord
  belongs_to :user
  validates :number, uniqueness: { scope: [:user_id] }

  def assign_verification_code
    self.code = SecureRandom.hex(6)
  end

  def verify_code(code)
    return unless self.code == code

    self.is_verified = true
    self.code = nil
  end
end
