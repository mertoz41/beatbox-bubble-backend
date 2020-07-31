Rails.application.routes.draw do
  resources :sharedsongs
  resources :shares
  resources :songs
  resources :comments
  resources :users
  resources :follows
  resources :posting
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # put '/add', to: 'users#addtrack'
  post '/login', to: 'auth#create'
  patch '/add', to: 'users#addtrack'
  get '/timeline/:id', to: 'users#timeline'
  get '/explore', to: 'sharedsongs#explore'
end
