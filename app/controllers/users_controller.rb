class UsersController < ApplicationController

    skip_before_action :authenticate_user, only: :create

    def index
        @users = User.All
        render json: @users, status: 200
    end

    def show
        render json: @user, status: 200
    end

    def create
        @user = User.create(user_params)
        if @user.save
            render json: @user, status: 201
        else
            render json: {errors: @user.errors.full_messages}, status: 503
        end
    end

    def update
        if current_user.update(user_params)
            render json: current_user, status: 200
        else
            render json: {errors: current_user.errors.full_messages}, status: 503
        end
    end

    def destroy
        current_user.destroy
    end

    def user_params
        params.permit(:name, :user_name, :email, :password)
    end

    def current_user
        @current_user ||= User.find_by(params[:id])
    end
end
