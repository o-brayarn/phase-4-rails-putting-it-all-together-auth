class SessionsController < ApplicationController
  before_action :authorize, except: :create
  #   skip_before_action :authorize, only: :create

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: ["Invalid username or passsword"] }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    render json: {}, status: :no_content
  end

  private

  def authorize
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end
end
