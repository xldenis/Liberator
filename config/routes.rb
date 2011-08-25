DeviseRolesUserManagement::Application.routes.draw do
  get "articles/create"

  get "articles/new"

  get "articles/show"

  get "articles/edit"

  get "articles/update"

  devise_for :users, :controllers => {:registrations => "registrations"} 
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  resources :token_authentications, :only => [:create, :destroy]
  resources :user, :controller => "user"
  resources :articles
  root :to => "dashboard#index"
end
