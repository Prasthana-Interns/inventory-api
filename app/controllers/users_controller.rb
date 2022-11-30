class UsersController < ApplicationController

  before_action :authorize_admin_token,except: [:create]
  before_action :set_user, only: [:update, :destroy, :accept_pending_request]

    def index
      if  @current_user.roles.exists?("role_type": 'Admin')
        users = User.all
        render json: users,status: :ok
      else
        render json: { message: :unauthorized },status: :unauthorized
      end
    end
    
    def create
      @user = User.create(user_params)
        params[:roles].each do |role|
          UserRole.create(user: @user, role_id: role.to_i) 
      end
      render json: @user ,status: :ok,serializer: UserSerializer
    end

    def show
       @user = User.find_by(emp_id: params[:emp_id])
      render json: @user,serializer: UserSerializer
    end

    def update
      @user.update(user_params)
      render json: @user,serializer: UserSerializer
    end

    def destroy
     @user.destroy
    end

    def pending_users
     if @current_user.roles.exists?("role_type": 'Admin')
        begin
           @users = User.where("approved": false)
          render json: @users
        rescue 
         render json: "No pending users"
        end
      else
         render json: { message: :unauthorized },status: :unauthorized
      end
    end

    def accept_pending_request
        @user.approved = true
        @user.update("approved":true)
        render json: {message: "approve successful"},status: :ok
    end

    private

    def set_user
      @user = User.find_by(emp_id: params[:emp_id]) if @current_user.roles.exists?("role_type": 'Admin')
      render json: { message: :unauthorized },status: :unauthorized unless @current_user.roles.exists?("role_type": 'Admin')

    end

    def user_params
      params.require(:user).permit(:name, :phone_number, :email, :designaton, :password, :approved, :emp_id)
    end

end
