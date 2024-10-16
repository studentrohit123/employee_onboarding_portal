class Users::SessionsController < Devise::SessionsController
  before_action :check_two_factor_auth, only: [:create]

  def check_two_factor_auth
    user = User.find_by(email: params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      user.generate_two_factor_code
      UserMailer.send_two_factor_code(user).deliver_now
      redirect_to users_verify_two_factor_path(user_id: user.id)
    end
  end

  def verify_two_factor
    @user = User.find(params[:user_id])
    if request.post?
      if @user.verify_two_factor_code(params[:two_factor_code])
        @user.invalidate_two_factor_code
        sign_in(@user)
        redirect_to root_path, notice: 'Successfully logged in with 2FA!'
      else
        flash.now[:alert] = 'Invalid or expired code'
      end
    end
  end
end
