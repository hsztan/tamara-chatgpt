Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/chat', to: 'chat#create'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'chat#index'
end
