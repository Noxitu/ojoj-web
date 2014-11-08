Rails.application.routes.draw do
  resources :users
  resources :tasks
  resources :subs
  get 'subs/new/:task_id' => 'subs#new', :as => 'new_sub_with_id'
  get 'tester_api_get' => 'subs#tester_api_get'
  get 'tester_api_set/:id/:result' => 'subs#tester_api_set'
  get 'tester_api_set/:id/:result/:cpu/:mem' => 'subs#tester_api_set'
  
  get 'login' => 'users#login', :as => 'login'
  get 'register' => 'users#register', :as => 'register'
  post 'login' => 'users#login_attempt'
  post 'register' => 'users#register_attempt'
  get 'logout' => 'users#logout', :as => 'logout'

  root 'tasks#index'
end
