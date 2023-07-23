class AuthenticationController < ApplicationController
    skip_before_action :authenticate_user, only: :create
  
    def create
      @user = User.find_by(user_name: params[:user_name])
  
      if @user&.authenticate(params[:password])
        token = jwt_encode({ user_id: @user.id })
  
        render json: { token: }, status: 200
      else
        render json: { errors: ['Invalid user_name or password'] }, status: 400
      end
    end
  
    def destroy
      Current.user = nil
      render json: { status: 200, message: 'Logged out' }
    end
  
    def show
      render json: Current.user.attributes.except('password', 'password_digest'), status: 200
    end
  end
  