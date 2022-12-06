class UsersController < ApplicationController
 
  before_action :authorize_admin_access,except: [:create, :show]
  before_action :authorize_employee_access,only: [:show]
  before_action :set_user, only: [:update, :destroy, :accept_pending_request, :show]

    def index
      users = User.where("approved": true)
      render json: users,status: :ok,each_serializer: UserSerializer
    end 
    
    def create
      begin
        @user = User.create!(user_params)
          params[:roles].each do |role|
            UserRole.create!(user: @user, role_type: role) 
          end
        render json: @user,status: :created, serializer: EmployeeSerializer
      rescue ActiveRecord::RecordInvalid => e 
        render json: { error: " email is already in use or provide correct data  instead" },status: :bad_request
      end
    end

    def search
      @user = User.search(params[:search])
      render json: @user, each_serializer: UserSerializer, status: :ok
    end

    def show
      render json: @user,status: :created, serializer: EmployeeSerializer
    end

    def search
      @user = User.search(params[:search])
      render json: @user, each_serializer: UserSerializer, status: :ok
    end
    
    def update
      @user.update(user_params)
      render json: @user, status: :ok, serializer: EmployeeSerializer
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
        render json:@users, status: :ok, serializer: EmployeeSerializer
      end
    end

    def accept_pending_request
        @user.approved = true
        @user.update("approved":true)
        render json: {message: "approve successful"}, status: :ok, each_serializer: UserSerializer
    end 

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :phone_number, :email, :designation, :approved)
    end

end
