class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_user!, only: %i[create google]

  def create
    user = User.find_by(email: params[:user][:email])
    if user
      if user.valid_password? params[:user][:password]
        render json: { token: JsonWebToken.encode(sub: user.id), user: {id: user.id, email: user.email }}
      else
        render json: { errors: ['Invalid email or password'] }
      end
    else
      render json: {errors: ["Email doesn't exist"]}, status: :unprocessable_entity
    end
  end

  def google
    user = User.find_or_create_by(user_params)
    user.save(validate: false) unless user.persisted?

    render json: { token: JsonWebToken.encode(sub: user.id), user: {id: user.id, email: user.email}}, status: :ok
  end

  def destroy
    log_out current_user
    render json: { message: 'You have successfully logged out.' }, status: :ok
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
