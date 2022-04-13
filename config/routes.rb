Rails.application.routes.draw do
  get 'users/new', to: 'users#new', as:'signup_path'
  root 'static_pages#home'
  get  'help',    to: 'static_pages#help' 
  get  'about',   to: 'static_pages#about'
  get  'contact', to: 'static_pages#contact'
  get  'signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end
