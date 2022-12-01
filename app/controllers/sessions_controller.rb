class SessionsController < ApplicationController

   def login
     @user = User.find_by( emp_id: params[:user][:emp_id] )
      if @user.approved == true
        if @user && @user.authenticate(params[:user][:password])
          token=encode_token({user_id: @user.id})
          time = (Time.now+24.hours).strftime("%m-%d-%Y %H:%M").to_i
          render json: { user: @user,userrole: @user.user_roles, token: token}
        else
          render json: { error: "Invalid emp_id or password" },status: :unprocessable_entity
        end
      else
        render json: { message: "unauthorized" },status: :unauthorized
      end
    end

end
