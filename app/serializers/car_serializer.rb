class CarSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :image, :model, :color, :rent, :description, :image_url
end
