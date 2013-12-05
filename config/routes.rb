StoneyPoint::Application.routes.draw do
  resources :work_days

  resources :housings

  resources :caddies

  resources :golfers

  resources :jobs

  resources :committees

  resources :volunteers

  root :to => 'volunteers#index'

end
