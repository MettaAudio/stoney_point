StoneyPoint::Application.routes.draw do
  resources :housings

  resources :caddies

  resources :golfers

  resources :jobs

  resources :committees

  resources :volunteers

  root :to => 'volunteers#index'

end
