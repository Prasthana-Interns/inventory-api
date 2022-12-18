class ApplicationController < ActionController::API

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def encode_token(payload, exp:Time.now+24.hours)
    JWT.encode(payload, SECRET_KEY)
  end

  def authorize_admin_access
    token_header = request.headers["Authorization"]
    if token_header
      begin
        decoded_token =  JWT.decode(token_header, SECRET_KEY)
        user_id = decoded_token[0]['user_id']
        @current_user = User.find_by!(id: user_id)
      raise Exception  unless isAdmin
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message },status: :not_found
      rescue JWT::DecodeError => e
        render json: { errors: e.message },status: :unauthorized
      rescue Exception => e
        render json: {error: "unauthorized"},status: :unauthorized
      end
    else
      render json: { message: "Token Not Found" },status: :forbidden
    end      
  end

  def authorize_employee_access
    token_header = request.headers["Authorization"]
    if token_header
      begin
        decoded_token =  JWT.decode(token_header, SECRET_KEY)
        user_id = decoded_token[0]['user_id']
        @current_user = User.find_by!(id: user_id)
      return  unless isEmployee
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message },status: :not_found
      rescue JWT::DecodeError => e
        render json: { errors: e.message },status: :unauthorized
      rescue Exception  => e
        render json: {error: e.message},status: :unauthorized
      end
    else
      render json: { message: "Token Not Found" },status: :forbidden
     end      
  end

  def isAdmin
    @current_user.user_roles.pluck(:role_type).include?('Admin')
  end

  def isEmployee
    @current_user.user_roles.pluck(:role_type).include?('Employee')
  end

end