class UserSerializer < ActiveModel::Serializer
  attributes :id, :emp_id, :phone_number, :email, :designaton,:roles
  has_many :roles
end
  