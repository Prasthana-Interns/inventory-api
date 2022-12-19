class EmployeeSerializer < ActiveModel::Serializer
  attributes :id,:name, :emp_id, :phone_number, :email, :designation, :user_roles

  def user_roles
    object.user_roles.pluck(:role_type)
  end
end
