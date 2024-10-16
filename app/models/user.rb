class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def generate_two_factor_code
    self.two_factor_code = rand(100000..999999).to_s
    self.two_factor_expires_at = 10.minutes.from_now
    save!
  end

  def invalidate_two_factor_code
    self.two_factor_code = nil
    self.two_factor_expires_at = nil
    save!
  end

  def verify_two_factor_code(code)
    self.two_factor_code == code && two_factor_expires_at > Time.current
  end
end
