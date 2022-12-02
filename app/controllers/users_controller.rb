class UsersController < ApplicationController

  before_action :authorize_admin_access,except: [:create, :show, :login]
  before_action :authorize_employee_access,only: [:show]
  before_action :set_user, only: [:update, :destroy, :accept_pending_request]

    def index
      users = User.where("approved": true)
      render json: users,status: :ok,each_serializer: UserSerializer
    end
    
    def create
      @user = User.create(user_params)
        params[:roles].each do |role|
          UserRole.create(user: @user, role_type: role) 
      end
      render json: @user,status: :created, serializer: UserSerializer
    end

    def show
       if @current_user.user_roles.pluck(:role_type).include?('Admin')
        @user = User.find(params[:id])
        render json: @user, status: :ok, serializer: UserSerializer
      else
        if @current_user.id  == params[:id].to_i 
          @user = User.find(params[:id])
          render json: @user, status: :ok, serializer: UserSerializer
        else
          render json: "Unauthorized", status: :unauthorized
        end
      end
    end

    def update
      @user.update(user_params)
      render json: @user, status: :ok, serializer: UserSerializer
    end

    def destroy
      @user.destroy
      render status: :ok
    end

    def pending_users
        @users = User.where("approved": false)
      if @users.empty?
        render status: :no_content
      else
        render json:@users, status: :ok
      end
    end

    def accept_pending_request
        @user.approved = true
        @user.update("approved":true)
        render json: {message: "approve successful"},status: :ok
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :phone_number, :email, :designaton, :password)
    end

end
