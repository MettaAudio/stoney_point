StoneyPoint::Application.routes.draw do
  resources :work_days

  resources :housings

  resources :caddies

  resources :golfers

  resources :jobs

  resources :committees

  resources :volunteers

  post "/add_volunteer_committee", to: "volunteers#add_committee", as: 'add_volunteer_committee'
  post "/add_volunteer_job", to: "volunteers#add_job", as: 'add_volunteer_job'

  root :to => 'volunteers#index'

end
