class UsersController < ApplicationController
 
  before_action :authorize_admin_access,except: [:create, :show, :update]
  before_action :authorize_employee_access,only: [:show, :update] 
  before_action :set_user, only: [:update, :destroy]

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
        render json: @user,status: :created, serializer: SessionSerializer
      rescue ActiveRecord::RecordInvalid => e 
        render json: { error: " email is already in use or provide correct data  instead" },status: :bad_request
      end
    end

    def search
      @users = User.search(params[:search])
      @user = @users.where(approved: true)
      if  @user
        render json: @user, each_serializer: UserSerializer, status: :ok 
      end
    end

    def show
      if @current_user.user_roles.pluck(:role_type).include?('Admin')
        set_user
        render json: @user,status: :ok, serializer: UserSerializer
      else
        if @current_user.id  == params[:id].to_i 
          set_user
          render json: @user, status: :ok, serializer: UserSerializer
        else
          render json: {error:"Unauthorized"}, status: :unauthorized
        end
      end
    end

    def update
      if @current_user.user_roles.pluck(:role_type).include?('Admin')
        @user.update(user_params) 
        render json: @user, status: :ok, serializer: EmployeeSerializer  
      elsif @current_user.user_roles.pluck(:role_type)==['Employee'] && @current_user.id ==@user.id #params[:id].to_i
        @user.update(employee_params)  
        render json: @user, status: :ok, serializer: EmployeeSerializer
      else
        render json:"Unauthorized"
      end
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
        render json:@users, status: :ok, each_serializer: EmployeeSerializer
      end
    end
  
    private

    def set_user
      @user = User.find(params[:id])
    end

    def employee_params
      params.require(:user).permit(:phone_number, :name)
    end

    def user_params
      params.require(:user).permit(:name, :phone_number, :email, :designation, :approved)
    end

end
