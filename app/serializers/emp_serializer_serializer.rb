class EmpSerializerSerializer < ActiveModel::Serializer
  attributes :id,:name, :emp_id, :phone_number, :email, :designation
end
