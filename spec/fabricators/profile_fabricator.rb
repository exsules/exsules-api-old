Fabricator(:profile) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  handle { Faker::Internet.user_name }
  bio "My awesome bio, yay"
  sex "m"
  location "Sweden, Norrköping"
  birthday Date.today
end
