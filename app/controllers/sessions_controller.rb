class SessionsController < ApplicationController

   def login
     @user = User.find_by(emp_id: params[:user][:emp_id])
      if @user.approved == true
        if @user && @user.authenticate(params[:user][:password])
          token=encode_token({emp_id: @user.emp_id,email: @user.email})
          time = (Time.now+24.hours).strftime("%m-%d-%Y %H:%M").to_i
          render json: { user: @user, token: token,exp: time},status: :ok
        elsif
          render json: {error: "Invalid emp_id or password"},status: :unprocessable_entity
        end
      else
        render json: {message: "unauthorized"},status: :unauthorized
      end
  end

  def reset_password
    @user = User.find_by(params[:emp_id])
    @user.password = nil
    @user.save
    render plain: "U r password has been updated successfully"
  end

  def logout
    byebug
    p user.emp_id
    user[:emp_id] = nil
    p user.emp_id

  end
end
