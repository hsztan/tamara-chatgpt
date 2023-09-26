Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/ask', to: 'messages#create'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'messages#index'
end
