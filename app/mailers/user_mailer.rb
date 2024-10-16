class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def send_two_factor_code(user)
    @user = user
    @code = user.two_factor_code
    mail(to: @user.email, subject: 'Your Two-Factor Authentication Code')
  end
end
