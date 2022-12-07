class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :emp_id, :designation, :email, :user_roles

  def user_roles
   object.user_roles.pluck(:role_type)
  end

end
