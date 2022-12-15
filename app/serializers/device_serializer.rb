class DeviceSerializer < ActiveModel::Serializer
  attributes :id , :name, :device_type, :device_no, :os, :image_url
  has_one :user 
end
