Rails.application.routes.draw do
  resources :users
  
  get 'login' => 'users#login', :as => 'login'
  get 'register' => 'users#register', :as => 'register'
  post 'login' => 'users#login_attempt'
  post 'register' => 'users#register_attempt'
  get 'logout' => 'users#logout', :as => 'logout'

  root 'welcome#index'
end
