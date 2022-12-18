class UsersController < ApplicationController
 
  before_action :authorize_admin_access,except: [:create, :show, :update]
  before_action :authorize_employee_access,only: [:show, :update] 
  before_action :set_user, only: [:show,:update, :destroy]

    def index
      users = User.where(approved: true).order(:emp_id)
      render json: users,status: :ok,each_serializer: UserSerializer
    end 
    
    def create
      user = User.create!(user_params)
        params[:roles].each do |role|
          UserRole.create!(user: user, role_type: role) 
        end
      render json: user,status: :created, serializer: SessionSerializer
      rescue ActiveRecord::RecordInvalid => e 
        render json: { error: e.message },status: :unprocessable_entity
    end

    def search
      users = User.search(params[:search]).order(:emp_id)
      render json: users, each_serializer: UserSerializer, status: :ok
    end

    def show
      if isAdmin
       render json:@user,status: :ok, serializer: UserSerializer 
      elsif @current_user == @user
        render json:@user, status: :ok, serializer: UserSerializer
      else
        render json: {error:"Unauthorized"}, status: :unauthorized
      end
    end

    def update
      @user.update(user_params)
      render json: @user, status: :ok, serializer: EmployeeSerializer  
    end

    def destroy
      @user.destroy
      head :ok
    end

    def pending
      users = User.where(approved: false)
      head :no_content if users.empty?
      render json:users, status: :ok, each_serializer: EmployeeSerializer unless users.empty?
    end
  
    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :phone_number, :email, :designation, :approved)
    end

end
