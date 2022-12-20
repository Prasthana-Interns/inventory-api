class SessionsController < ApplicationController

  def login
    user = User.find_by!(emp_id: params[:user][:emp_id])
      if user.approved == true 
       user.update(password:params[:user][:password])  if user.password_digest == nil
        if user && user.authenticate(params[:user][:password])
          token=encode_token( {user_id: user.id} )
          render json: { user: SessionSerializer.new( user), token: token }, status: :ok
        else 
          render json: { error: "Invalid emp_id or password" },status: :unprocessable_entity
        end
      else
        render json: { message: "unauthorized" },status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: "Invalid emp_id or password" },status: :unprocessable_entity
  end

  def reset_password
   user = User.find_by_emp_id(params[:emp_id])
   return if user.nil?
   user.update(password_digest: nil) 
   head :ok 
  end

end