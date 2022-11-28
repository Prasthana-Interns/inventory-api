class UsersController < ApplicationController

  before_action :authorized,except: [:create]
  # before_action :authorized_user,except: [:create]
  # before_action :set_user, only: [:show, :update, :destroy]
  
  # attr_accessor :current_user

    def index
      users = User.all
      render json: users,status: :ok
    end
    
    def create
      @user = User.create(user_params)
      render json:@user,status: :ok
      # params[:roles].each do |role|
      #     UserRole.create(user: @user, role_id: role.to_i) 
      #   end
    end

    def show
      render json: @user
    end

    def update
      @user.update(user_params)
        render json: @user
    end

    def destroy
     @user.destroy
    end

    def pending_users
      @users = User.where("approved": false)
      render json: @users
    end
    private

    def set_user
      @user = User.find_by(emp_id: params[:emp_id])
    end

    def user_params
      params.require(:user).permit(:name, :phone_number, :email, :designaton, :password, :approved, :emp_id)
    end
end