class ImageSerializer
  include JSONAPI::Serializer  #activemodel: :serializer explicitly taken
  attributes :id , :name, :device_type, :device_no, :os ,:user_id , :image_url
end
