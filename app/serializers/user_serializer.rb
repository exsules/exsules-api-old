class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :initial_setup, :language, :disable_mail

  has_one :profile, serializer: ProfileSerializer
end
