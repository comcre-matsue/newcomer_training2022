Rails.application.routes.draw do
  root 'static_pages#home'
  get 'help',     to: 'static_pages#help', as: 'help'
  get 'about',    to: 'static_pages#about'
  get 'contact',  to: 'static_pages#contact'
  resources :microposts
  # resources :users
  get '/signup', to: 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
