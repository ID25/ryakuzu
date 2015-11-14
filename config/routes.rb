Ryakuzu::Engine.routes.draw do
  post 'update_hash', to: 'main#update_hash', as: :update_hash

  root 'main#index'
end
