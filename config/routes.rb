Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update]
  resources :games , only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :bookings, only: [:new, :create, :update]
  end
  resources :bookings, only: [:index, :show]
  mount Attachinary::Engine => "/attachinary"
  get "/games/:id/get_available_time_slots/:date" => "games#get_available_time_slots"
end
