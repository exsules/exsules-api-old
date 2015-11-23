require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_application
  end

  #devise_for :users
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }, skip: [:passwords]

  scope module: :v1, constraints: ApiConstraint.new(version: 1) do
    get 'users/me' => 'users#me'

    get 'profiles/:handle' => 'profiles#show'
    get 'profiles' => 'profiles#index'

    get 'posts/:id' => 'posts#show'

  end
end
