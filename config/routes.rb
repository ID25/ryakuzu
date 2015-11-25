Ryakuzu::Engine.routes.draw do
  resources :tables, only: [:create]

  root 'main#index'
end
