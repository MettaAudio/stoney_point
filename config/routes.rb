StoneyPoint::Application.routes.draw do
  resources :volunteers

  root :to => 'volunteers#index'

end
