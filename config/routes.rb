Rails.application.routes.draw do

  resources :platos, :only => [:new, :create, :destroy]
  resources :rovers, :only => [:edit, :update]
  resources :sessions, :only => [:create, :destroy]

  root :to => 'platos#new'
  get 'rovers/:id/go' => 'rovers#go', :as => :go
  patch 'rovers/:id/go' => 'rovers#go'
end
