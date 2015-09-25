# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  auth_token             :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  username               :string
#  username_lower         :string
#  photo_fingerprint      :string
#  picture                :string
#
# Indexes
#
#  index_users_on_auth_token            (auth_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

Fabricator(:user) do
  username { Faker::Internet.user_name.gsub('.', '-') }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  initial_setup { true }
  language 'en'

  after_create { |user| Fabricate(:profile, handle: user.username, user_id: user.id) }
  #profile { Fabricate(:profile, handle: Faker::Internet.user_name) }
end
