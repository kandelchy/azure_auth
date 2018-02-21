Rails.application.routes.draw do
  resources :infos

  root "infos#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: 'users/sessions'}
end
