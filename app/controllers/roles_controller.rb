class RolesController < ApplicationController

    def create
      role = Role.create(role_params)
      render json: role
    end

    private

    def role_params
      params.require(:role).permit(:role_type)
    end
end