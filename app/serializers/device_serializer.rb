class DeviceSerializer < ActiveModel::Serializer
  attributes :id , :name, :device_type, :device_no, :os
  has_one :user
end
