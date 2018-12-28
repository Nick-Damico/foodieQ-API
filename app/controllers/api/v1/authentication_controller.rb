class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_user!, only: %i[create]

  def create
    user = User.find_by(email: params[:user][:email])
    if user.valid_password? params[:user][:password]
      render json: { token: JsonWebToken.encode(sub: user.id, email: user.email) }
    else
      render json: { errors: ['Invalid email or password'] }
    end
  end

  def destroy
    log_out current_user
    render json: { message: 'You have successfully logged out.' }, status: :ok
  end
end
