class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :location, :sex, :searchable, :birthday, :handle, :bio
  attribute :first_name, key: 'first-name'
  attribute :last_name, key: 'last-name'
end
