Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_application
  end

  #devise_for :users

  scope module: :v1, constraints: ApiConstraint.new(version: 1) do
    get 'users/me' => 'users#me'

    get 'profiles/:id' => 'profiles#show'

  end
end
