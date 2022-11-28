class UserSerializer < ActiveModel::Serializer
  attributes :id, :emp_id, :phone_number, :email, :designaton
  has_many :roles
end
  