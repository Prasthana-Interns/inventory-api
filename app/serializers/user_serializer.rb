class UserSerializer < ActiveModel::Serializer
<<<<<<< HEAD
  attributes :id, :emp_id, :phone_number, :email, :designation, :user_roles
=======

  attributes :id, :name, :emp_id, :phone_number, :email, :designation, :user_roles
>>>>>>> c88ccca4eb112620f3919b55407ded99f1096a69
  has_many :devices
  
  def user_roles
    object.user_roles.pluck(:role_type)
  end
  
end
  
