Ryakuzu::Engine.routes.draw do
  resources :tables, only: [:create]

  post 'column',          to: 'tables#column',          as: :column
  post 'column_options',  to: 'tables#column_options',  as: :column_options
  post 'remove_column',   to: 'tables#remove_column',   as: :remove_column
  post 'remove_table',    to: 'tables#remove_table',    as: :remove_table
  post 'add_column_form', to: 'tables#add_column_form', as: :add_column_form
  post 'add_column',      to: 'tables#add_column',      as: :add_column
  post 'add_table',       to: 'tables#add_table',       as: :add_table
  post 'create_table',    to: 'tables#create_table',    as: :create_table
  post 'new_column',      to: 'tables#new_column',      as: :new_column

  root 'main#index'
end
