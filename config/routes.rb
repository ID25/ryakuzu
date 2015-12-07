Ryakuzu::Engine.routes.draw do
  resources :tables, only: [:create]
  post 'column',         to: 'tables#column',         as: :column
  post 'column_options', to: 'tables#column_options', as: :column_options
  post 'remove_column',  to: 'tables#remove_column',  as: :remove_column

  root 'main#index'
end
