class UserSerializer < ActiveModel::Serializer
  attributes :id, :emp_id, :phone_number, :email, :designaton, :user_roles

  def user_roles
    object.user_roles.pluck(:role_type)
  end
end
  