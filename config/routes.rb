Rails.application.routes.draw do
  resources :users
  resources :tasks
  resources :subs
  get 'subs/new/:task_id' => 'subs#new', :as => 'new_sub_with_id'
  get 'subs/ajax/:since/:id' => 'subs#ajax'
  get 'subs/ajax/:since' => 'subs#ajax'
  get 'subs/clear/:id' => 'subs#clear', :as => 'clear_sub'
  get 'tasks/:task_id/subs' => 'subs#index', :as => 'show_task_subs'
  
  get 'tester_api_get' => 'api#get'
  get 'tester_api_set/:id/:result' => 'api#set'
  get 'tester_api_set/:id/:result/:cpu/:mem' => 'api#set'
  
  get 'login' => 'users#login', :as => 'login'
  get 'register' => 'users#register', :as => 'register'
  post 'login' => 'users#login_attempt'
  post 'register' => 'users#register_attempt'
  get 'logout' => 'users#logout', :as => 'logout'
  
  get 'user/:id/permissions' => 'users#edit_permissions', :as => 'edit_user_permissions'
  post 'user/:id/permissions' => 'users#update_permissions'
  
  root 'tasks#index'
end
