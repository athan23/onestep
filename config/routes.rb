Rails.application.routes.draw do
  resources :boards, only: [:index, :show, :new, :create]
  root 'boards#new'
end
