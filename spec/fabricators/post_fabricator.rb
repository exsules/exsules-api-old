Fabricator(:post) do
  text { Faker::Lorem.sentences }

  profile
  from(fabricator: :profile)
end
