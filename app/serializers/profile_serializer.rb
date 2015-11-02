class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :location, :sex, :searchable, :birthday, :handle, :bio, :first_name, :last_name

  has_many :posts#, include: false
end
