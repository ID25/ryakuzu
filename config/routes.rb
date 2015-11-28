Ryakuzu::Engine.routes.draw do
  resources :tables, only: [:create]
  post 'column', to: 'tables#column', as: :column
  post 'column_options', to: 'tables#column_options', as: :column_options

  root 'main#index'
end
