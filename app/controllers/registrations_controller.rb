class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.build(sign_up_params)
    if user.save
      data = {
        success: true,
        message: "Registraion success message here later on."
      }
      render json: { user: data }, status: 201
    else
      warden.custom_failure!
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :password, :email)
  end
end
