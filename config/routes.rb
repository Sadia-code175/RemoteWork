Rails.application.routes.draw do
  get "notifications/index"
  get "home/index"
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resource :profile, only: [:show, :edit, :update]
  resources :jobs, only: [:index, :new, :create] do
    collection do
      get :search
      get :my_jobs, path: 'my-jobs'  # This defines my_jobs_path
    end
    member do
      post :apply
      post :hire
    end
  end
  
  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end
  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
