Rails.application.routes.draw do
  resources :players, only: [:show] do
    post :play
  end
end
